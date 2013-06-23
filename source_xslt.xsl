<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
 <xsl:template match="/">
 <html>
 <body>
 <xsl:for-each select="ROWSET/ROW">
 <h2><xsl:value-of select="ENAME"/></h2>
 </xsl:for-each>
 </body>
 </html>
 </xsl:template>
</xsl:stylesheet>