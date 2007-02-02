<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xhtml sht xsl"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:sht="http://crustytoothpaste.ath.cx/ns/stylesheet"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="css-base"/>
	<xsl:template match="sht:stylesheet">
		<xsl:element name="link" namespace="http://www.w3.org/1999/xhtml">
			<xsl:copy-of select="@type|@title"/>
			<xsl:choose>
				<xsl:when test="@class = 'default'">
					<xsl:attribute name="rel">stylesheet</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="rel">alternate stylesheet</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:attribute name="href"><xsl:value-of select="$css-base"/><xsl:text>/</xsl:text><xsl:value-of select="@href"/></xsl:attribute>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
