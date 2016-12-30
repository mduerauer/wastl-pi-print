<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">

        <html lang="en">
            <head>
                <meta charset="UTF-8" />
                <title>Depesche</title>

                <link rel="stylesheet" href="../usr/share/styles/bootstrap.min.css" />
                <link rel="stylesheet" href="../usr/share/openlayers/ol.css" />
                <link rel="stylesheet" href="../usr/share/styles/depesche.css" />

                <meta name="viewport" content="width=device-width, initial-scale=1" />
            </head>
            <body>

                <header>
                    <div class="container">
                        <div class="row">
                            <div class="col-xs-6">
                                <p>Freiwillige Feuerwehr Karlstetten</p>
                            </div>
                            <div class="col-xs-6">
                                <p class="text-right">2016-12-28 11:01:00</p>
                            </div>
                        </div>
                    </div>
                </header>

                <xsl:for-each select="InfoscreenModel/EinsatzData/Einsatz[position()=1]">

                    <div class="container">

                        <div class="row">
                            <div class="col-xs-10">
                                <h1><xsl:value-of select="Meldebild"/>&#160;<small><xsl:value-of select="EinsatzID"/></small></h1>
                            </div>
                            <div class="col-xs-2">
                                <div class="alert alert-success alarmstufe" role="alert">
                                    <xsl:value-of select="Alarmstufe"/>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-6" id="einsatzort">
                                <h3>Einsatzort</h3>
                                <table class="table">
                                    <tr>
                                        <th>Straße</th>
                                        <td><xsl:value-of select="Strasse"/>&#160;<xsl:value-of select="Nummer1"/></td>
                                    </tr>
                                    <tr>
                                        <th>Ort</th>
                                        <td><xsl:value-of select="Plz"/>&#160;<xsl:value-of select="Ort"/></td>
                                    </tr>
                                    <tr>
                                        <th>Abschnitt</th>
                                        <td><xsl:value-of select="Abschnitt"/></td>
                                    </tr>
                                    <tr>
                                        <th>Bemerkung</th>
                                        <td><xsl:value-of select="Bemerkung"/></td>
                                    </tr>
                                </table>

                                <h3>Melder</h3>
                                <table class="table">
                                    <tr>
                                        <th>Name</th>
                                        <td><xsl:value-of select="Melder"/></td>
                                    </tr>
                                    <tr>
                                        <th>Erreichbarkeit</th>
                                        <td><xsl:value-of select="MelderTelefon"/></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-xs-6" id="einsatzdaten">
                                <h3>Einsatzdaten</h3>
                                <table class="table">
                                    <tr>
                                        <th>Einsatz-ID</th>
                                        <td><xsl:value-of select="EinsatzID"/></td>
                                    </tr>
                                    <tr>
                                        <th>Einsatz erzeugt</th>
                                        <td><xsl:value-of select="EinsatzErzeugt"/></td>
                                    </tr>
                                    <tr>
                                        <th>Alarmstufe</th>
                                        <td><xsl:value-of select="Alarmstufe"/></td>
                                    </tr>
                                    <tr>
                                        <th>Meldebild</th>
                                        <td><xsl:value-of select="Meldebild"/></td>
                                    </tr>
                                </table>

                                <h3>Alarmierte Einheiten</h3>
                                <table class="table">
                                    <tr>
                                        <th>Nr.</th>
                                        <th>Name</th>
                                        <th>Uhrzeit</th>
                                    </tr>
                                    <xsl:for-each select="Dispositionen/Disposition">
                                        <tr>
                                            <td><xsl:value-of select="position()" /></td>
                                            <td><xsl:value-of select="Name"/></td>
                                            <td><xsl:value-of select="DispoTime"/></td>
                                        </tr>
                                    </xsl:for-each>
                                </table>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <h3>Detailansicht</h3>
                                <div class="map" id="map-detail"></div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <h3>Detailansicht (Orthofoto)</h3>
                                <div class="map" id="map-photo"></div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <h3>Übersicht</h3>
                                <div class="map" id="map-overview"></div>
                            </div>
                        </div>

                        <textarea class="hidden" id="einsatz-adresse"><xsl:value-of select="Strasse"/>&#160;<xsl:value-of select="Nummer1"/>,&#160;<xsl:value-of select="Plz"/>&#160;<xsl:value-of select="Ort"/>,&#160;Österreich</textarea>

                    </div>

                </xsl:for-each>

                <footer>
                    <div class="container">
                        <p class="small">wastl-pi-print</p>
                    </div>
                </footer>

                <script src="../usr/share/jquery/jquery-3.1.1.min.js"></script>
                <script src="../usr/share/openlayers/ol.js"></script>
                <script src="../usr/share/scripts/depesche.js"></script>
                <script type="text/javascript">
                    var address = $('textarea#einsatz-adresse').val();
                    resolveCoordinates(address);
                </script>

            </body>
        </html>

    </xsl:template>
</xsl:stylesheet>
