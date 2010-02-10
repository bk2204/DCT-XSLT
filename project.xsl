<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="xsl ctxsl">
	<xsl:param name="ctxsl:project-name">Crusty Toothpaste XSLT 1.0</xsl:param>
	<xsl:param name="ctxsl:project-uri">http://crustytoothpaste.ath.cx/cgi-bin/cgit/xsl-sheets/</xsl:param>
	<xsl:param name="ctxsl:project-version">unreleased (pre-v2)</xsl:param>
	<xsl:param name="ctxsl:project-id">
		<xsl:value-of select="$ctxsl:project-name"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="$ctxsl:project-version"/>
		<xsl:if test="string-length($ctxsl:project-uri) != 0">
			<xsl:text> (</xsl:text>
			<xsl:value-of select="$ctxsl:project-uri"/>
			<xsl:text>)</xsl:text>
		</xsl:if>
	</xsl:param>
</xsl:stylesheet>
