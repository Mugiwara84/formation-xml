<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    <!-- C'est ce truc-là qui permet de mettre le bon DOCTYPE et la déclaration html. -->
    <xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes" />
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title>Hello World !</title>        
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            </head>
            <body>        
                <div>
                    <p>Hello World &lt;o__o&gt;</p>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>