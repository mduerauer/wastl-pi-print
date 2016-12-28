<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.5/css/bootstrap.min.css" integrity="sha384-AysaV+vQoT3kOAXZkl02PThvDr8HYKPZhNT5h/CXfBThSRXQ6jW5DO2ekP5ViFdi" crossorigin="anonymous" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            </head>
            <body>
                <div class="container">
                    <h1>Depesche</h1>
                    <xsl:for-each select="InfoscreenModel/EinsatzData/Einsatz">
                        <h2><xsl:value-of select="EinsatzID"/></h2>
                        <div id="einsatzdaten">
                            <h3>Einsatzdaten</h3>
                            <table class="table">
                                <tr>
                                    <th>Einsatz-ID</th>
                                    <td><xsl:value-of select="EinsatzID"/></td>
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
                        </div>

                        <div id="einsatzort">
                            <h3>Einsatzort</h3>
                            <table class="table">
                                <tr>
                                    <th>Straße</th>
                                    <td><xsl:value-of select="Strasse"/>&#160;<xsl:value-of select="Nummer1"/></td>
                                </tr>
                                <tr>
                                    <th>Ort</th>
                                    <td><xsl:value-of select="PLZ"/>&#160;<xsl:value-of select="Ort"/></td>
                                </tr>
                            </table>
                        </div>
                    </xsl:for-each>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>