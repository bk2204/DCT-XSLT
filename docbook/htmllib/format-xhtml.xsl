<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="ctxsl xsl">

	<xsl:template match="/">
		<xsl:apply-templates select="." mode="ctxsl:all-xhtml2xhtml"/>
	</xsl:template>

	<xsl:template match="@xml:lang" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy-of select="." />
	</xsl:template>

	<xsl:template match="*" mode="ctxsl:maybensnuke">
		<xsl:copy>
			<xsl:copy-of select="@*" />
			<xsl:apply-templates mode="ctxsl:maybensnuke" />
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
