<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="2.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes" />
    
    <xsl:variable name="nbActs" select="count(//ACT)"/>
    
    <xsl:template match="node()">
        <xsl:copy>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="ACT">
        <xsl:variable name="acte" select="count(preceding::ACT)+1"/>
        <xsl:copy>
            <xsl:attribute name="index">
                <xsl:value-of select="concat($acte,'/',$nbActs)"/>
            </xsl:attribute>
            <xsl:apply-templates select="node()"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>