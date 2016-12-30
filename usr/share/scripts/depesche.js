var capabilitiesUrl = 'http://www.basemap.at/wmts/1.0.0/WMTSCapabilities.xml';
var hydrantBaseUrl = 'https://www.osmhydrant.org/overpass/fire-water-utilities/';

var apiKey = "AIzaSyDx8EQ0HUam2BchZEUDoQvvaZ66_B7Q61s";

var latLng = [15.565833, 48.258598];
var coords = ol.proj.fromLonLat(latLng);

var mapDetail = new ol.Map({
    target: 'map-detail',
    view: new ol.View({
            center: coords,
            zoom: 19
        }
    ),
    units: 'm',
    controls: [],
    interactions: []
});

var mapPhoto = new ol.Map({
    target: 'map-photo',
    view: new ol.View({
            center: coords,
            zoom: 19
        }
    ),
    units: 'm',
    controls: [],
    interactions: []
});

var mapOverview = new ol.Map({
    target: 'map-overview',
    view: new ol.View({
            center: coords,
            zoom: 17
        }
    ),
    units: 'm',
    controls: [],
    interactions: []
});


var loadMaps = function() {
    // HiDPI support:
    // * Use 'bmaphidpi' layer (pixel ratio 2) for device pixel ratio > 1
    // * Use 'geolandbasemap' layer (pixel ratio 1) for device pixel ratio == 1
    var hiDPI = ol.has.DEVICE_PIXEL_RATIO > 1;
    //var layer = hiDPI ? 'bmaphidpi' : 'geolandbasemap';
    var layer = 'bmaphidpi';
    //var tilePixelRatio = hiDPI ? 2 : 1;
    var tilePixelRatio = 2;

    var iconFeatures=[];

    var iconFeature = new ol.Feature({
        geometry: new ol.geom.Point(ol.proj.transform(latLng, 'EPSG:4326',
            'EPSG:3857'))
    });

    iconFeatures.push(iconFeature);

    var vectorSource = new ol.source.Vector({
        features: iconFeatures //add an array of features
    });

    var iconStyle = new ol.style.Style({
        image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
            anchor: [16, 16],
            anchorXUnits: 'pixels',
            anchorYUnits: 'pixels',
            opacity: 0.75,
            src: '../usr/share/images/pointer.png'
        }))
    });


    var vectorLayer = new ol.layer.Vector({
        source: vectorSource,
        style: iconStyle
    });



    $.ajax(capabilitiesUrl).then(function(response) {
        var result = new ol.format.WMTSCapabilities().read(response);

        var optionsMap = ol.source.WMTS.optionsFromCapabilities(result, {
            layer: layer,
            matrixSet: 'google3857',
            requestEncoding: 'REST',
            style: 'normal'
        });

        var optionsPhoto = ol.source.WMTS.optionsFromCapabilities(result, {
            layer: 'bmaporthofoto30cm',
            matrixSet: 'google3857',
            requestEncoding: 'REST',
            style: 'normal'
        });

        var optionsPhotoOverlay = ol.source.WMTS.optionsFromCapabilities(result, {
            layer: 'bmapoverlay',
            matrixSet: 'google3857',
            requestEncoding: 'REST',
            style: 'normal'
        });

        optionsMap.tilePixelRatio = tilePixelRatio;

        mapDetail.addLayer(new ol.layer.Tile({
            source: new ol.source.WMTS(optionsMap)
        }));


        mapDetail.addLayer(vectorLayer);

        mapOverview.addLayer(new ol.layer.Tile({
            source: new ol.source.WMTS(optionsMap)
        }));

        mapOverview.addLayer(vectorLayer);

        mapPhoto.addLayer(new ol.layer.Tile({
            source: new ol.source.WMTS(optionsPhoto)
        }));

        mapPhoto.addLayer(new ol.layer.Tile({
            source: new ol.source.WMTS(optionsPhotoOverlay)
        }));


        mapPhoto.addLayer(vectorLayer);

    });

}

var loadHydrants = function() {

    var hydrantStyle = new ol.style.Style({
        image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
            anchor: [9, 9],
            anchorXUnits: 'pixels',
            anchorYUnits: 'pixels',
            opacity: 0.75,
            src: '../usr/share/images/hydrant.png'
        }))
    });

    var circleStyle = new ol.style.Style({
        stroke: new ol.style.Stroke({
            color: 'blue',
            width: 1
        }),
        fill: new ol.style.Fill({
            color: 'rgba(0, 0, 255, 0.02)'
        })
    });

    var extent = mapOverview.getView().calculateExtent(mapOverview.getSize());
    var upperLeft = ol.proj.toLonLat([extent[0], extent[1]]);
    var lowerRight = ol.proj.toLonLat([extent[2], extent[3]]);
    var hydrantUrl = hydrantBaseUrl + upperLeft[0] + "," + upperLeft[1] + "," + lowerRight[0] + ',' + lowerRight[1];

    var wgs84Sphere= new ol.Sphere(6378137);

    $.ajax(hydrantUrl).then(function (response) {

        var hydrants = [];
        var circles = [];

        $.each(response.elements, function (key, value) {

            var pos = [value.lon, value.lat];

            var hCoords = ol.proj.transform(pos, 'EPSG:4326', 'EPSG:3857');

            hydrants.push(
                new ol.Feature({
                    geometry: new ol.geom.Point(hCoords),
                    name: value.tags.name
                })
            );

            circles.push(
                new ol.Feature({
                    geometry: new ol.geom.Circle(hCoords, 100),
                    name: value.tags.name
                })
            );

        });

        var hydrantsSource = new ol.source.Vector({
            features: hydrants
        });

        var circlesSource = new ol.source.Vector({
            features: circles
        });

        var hydrantsLayer = new ol.layer.Vector({
            source: hydrantsSource,
            style: hydrantStyle
        });

        var circlesLayer = new ol.layer.Vector({
            source: circlesSource,
            style: circleStyle
        })

        mapDetail.addLayer(hydrantsLayer);
        mapDetail.addLayer(circlesLayer);

        mapOverview.addLayer(hydrantsLayer);
        mapOverview.addLayer(circlesLayer);

        mapPhoto.addLayer(hydrantsLayer);
        mapPhoto.addLayer(circlesLayer);

        window.status = 'ready_to_print';

    });

}

var resolveCoordinates = function(address ) {



    var geocodeUrl = "https://maps.googleapis.com/maps/api/geocode/json?address=" + address + "&key=" + apiKey;

    $.ajax(geocodeUrl).then(function (response) {

        console.log("geocode", response);
        if(response.status == "OK") {

            latLng = [
                response.results[0].geometry.location.lng,
                response.results[0].geometry.location.lat
            ];

            coords = ol.proj.fromLonLat(latLng);

            mapPhoto.getView().setCenter(coords);
            mapDetail.getView().setCenter(coords);
            mapOverview.getView().setCenter(coords);

            loadMaps();
            loadHydrants();

        };
    });

};