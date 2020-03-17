<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0">
    <xsl:template match="/">        
        <xsl:copy>        
            <xsl:apply-templates select="node()"/>            
        </xsl:copy>    
    </xsl:template>
    <!--Un truc bizarre, il commence sur la declaration XML en racine.
        Normalement, il n'est pas nécessaire d'expliciter ce template.-->
    <xsl:template match="PLAY">
        <!-- C'est là qu'on calcule la "variable" qu'on va passer en paramètre. -->
        <xsl:variable name="totAct" select="count(ACT)"/>
        <xsl:copy>
            <xsl:copy-of select="@*"/>            
            <xsl:apply-templates select="node()">
                <!-- On la passe en paramètre. L'avantage de typer c'est de capturer les erreurs à la compilation. -->
                <xsl:with-param name="totAct" select="$totAct" as="xs:integer"/>
            </xsl:apply-templates>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="*">
        <xsl:element name="{name()}">
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="ACT">
        <!-- Ne pas oublier de déclarer également le paramètre dans la fonction. -->
        <xsl:param name="totAct" select="1" as="xs:integer"/>
        <xsl:element name="ACT">
            <xsl:attribute name="index" select="concat(count(preceding-sibling::ACT)+1,'/',$totAct)"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>    
</xsl:stylesheet>