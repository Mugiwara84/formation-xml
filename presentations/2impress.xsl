<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xh="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xh" version="1.0">

    <xsl:output method="html" indent="no"/>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="xh:head">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
            <meta charset="utf-8"/>
            <!-- <meta name="viewport" content="width=1024"/>-->
            <meta name="apple-mobile-web-app-capable" content="yes"/>
            <meta name="author" content="Eric Sigaud"/>
            <link href="syntaxhighlighter/styles/shCore.css" rel="stylesheet" type="text/css"/>
            <link href="syntaxhighlighter/styles/shThemeDefault.css" rel="stylesheet" type="text/css"/>
            <link href="css/impress-semDev.css" rel="stylesheet"/>
            <link rel="shortcut icon" href="favicon.png"/>
            <link rel="apple-touch-icon" href="apple-touch-icon.png"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="xh:body">
        <body class="impress-not-supported">

            <div class="fallback-message">
                <p>Your browser <b>doesn't support the features required</b> by impress.js, so you are presented with a
                    simplified version of this presentation.</p>
                <p>For the best experience please use the latest <b>Chrome</b>, <b>Safari</b> or <b>Firefox</b>
                    browser.</p>
            </div>

           <!-- <div id="licence">
                <a href="http://creativecommons.org/licenses/by/3.0/deed.fr"
                    title="Ce document est publié suivant une licence Creative Commons &quot;Attribution 3.0 non transposé&quot; (CC BY 3.0)"
                    >CC By 3.0</a>
                <img src="images/cc-by.svg"
                    alt="Ce document est publié suivant une licence Creative Commons &quot;Attribution 3.0 non transposé&quot; (CC BY 3.0)"
                    height="32px"/>

            </div>-->


           <!-- <div id="footer">
                <h1>
                    <img src="images/logo520.png" alt="DYOMEDEA : Guide de haute technologie" id="debutTet"/>
                    <img src="images/bout.png" alt="..." id="finTet"/>
                </h1>
            </div>-->

            <div id="impress">

                <xsl:apply-templates select="node()"/>

            </div>
            <div class="hint">
                <p>Use a spacebar or arrow keys to navigate</p>
            </div>
            <script>
if ("ontouchstart" in document.documentElement) { 
    document.querySelector(".hint").innerHTML = "<p>Tap on the left or right to navigate</p>";
}
</script>

            <!--
    
    Last, but not least.
    
    To make all described above really work, you need to include impress.js in the page.
    I strongly encourage to minify it first.
    
    In here I just include full source of the script to make it more readable.
    
    You also need to call a `impress().init()` function to initialize impress.js presentation.
    And you should do it in the end of your document. Not only because it's a good practice, but also
    because it should be done when the whole document is ready.
    Of course you can wrap it in any kind of "DOM ready" event, but I was too lazy to do so ;)
    
-->
            <script src="js/impress.js"/>
            <script>impress().init();</script>
            <script type="text/javascript" src="syntaxhighlighter/scripts/shCore.js"/>
            <script type="text/javascript" src="syntaxhighlighter/scripts/shBrushXml.js"/>
            <script type="text/javascript" src="syntaxhighlighter/scripts/shBrushJScript.js"/>
            <script type="text/javascript" src="syntaxhighlighter/scripts/shBrushPlain.js"/>
            <script type="text/javascript" src="syntaxhighlighter/scripts/shBrushJava.js"/>
            <script type="text/javascript">
     SyntaxHighlighter.all()
</script>

        </body>
    </xsl:template>

    <xsl:template match="xh:body/xh:div">

        <div class="step">

            <xsl:apply-templates select="@*[not(name()='class')]"/>

            <xsl:variable name="direction">
                <xsl:choose>
                    <xsl:when test="preceding-sibling::xh:div/@data-dir|self/@data-dir">
                        <xsl:value-of select="(preceding-sibling::xh:div/@data-dir[1]|self/@data-dir)[last()]"/>
                    </xsl:when>
                    <xsl:otherwise>right</xsl:otherwise>
                </xsl:choose>
            </xsl:variable>

            <xsl:if test="not(@data-x)">
                <xsl:variable name="previous-div"
                    select="preceding-sibling::xh:div[@data-x and not(@data-out-of-sequence)][1]"/>
                <xsl:variable name="previous">
                    <xsl:choose>
                        <xsl:when test="$previous-div">
                            <xsl:value-of select="$previous-div/@data-x"/>
                        </xsl:when>
                        <xsl:otherwise>0</xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="nbsteps"
                    select="count(preceding-sibling::xh:div[not(@data-out-of-sequence)]) - count($previous-div/preceding-sibling::xh:div[not(@data-out-of-sequence)])"/>
                <xsl:attribute name="data-x">
                    <xsl:choose>
                        <xsl:when test="$direction = 'right'">
                            <xsl:value-of select="$previous + $nbsteps * 1500"/>
                        </xsl:when>
                        <xsl:when test="$direction = 'left'">
                            <xsl:value-of select="$previous - $nbsteps * 1500"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$previous"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>

            <xsl:if test="not(@data-y)">
                <xsl:variable name="previous-div"
                    select="preceding-sibling::xh:div[@data-y and not(@data-out-of-sequence)][1]"/>
                <xsl:variable name="previous">
                    <xsl:choose>
                        <xsl:when test="$previous-div">
                            <xsl:value-of select="$previous-div/@data-y"/>
                        </xsl:when>
                        <xsl:otherwise>0</xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:variable name="nbsteps"
                    select="count(preceding-sibling::xh:div[not(@data-out-of-sequence)]) - count($previous-div/preceding-sibling::xh:div[not(@data-out-of-sequence)])"/>
                <xsl:attribute name="data-y">
                    <xsl:choose>
                        <xsl:when test="$direction = 'down'">
                            <xsl:value-of select="$previous + $nbsteps * 800"/>
                        </xsl:when>
                        <xsl:when test="$direction = 'up'">
                            <xsl:value-of select="$previous - $nbsteps * 800"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$previous"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>


            <xsl:apply-templates select="node()"/>

        </div>

    </xsl:template>

    <xsl:template match="xh:div[@class='header']"/>

</xsl:stylesheet>
