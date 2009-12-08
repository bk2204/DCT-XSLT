<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xsl">
	<xsl:import href="pstp.xsl" />
	<xsl:import href="../htmllib/pstp.xsl" />
	<xsl:output method="html"
		encoding="UTF-8"
		indent="no"
		doctype-public="-//W3C//DTD HTML 4.01//EN"
		doctype-system="http://www.w3.org/TR/html4/strict.dtd"/>
	<xsl:namespace-alias stylesheet-prefix="xhtml" result-prefix="#default" />
	<xsl:template match="/">
		<xsl:apply-templates select="." mode="ctxsl:all-xhtml2xhtml"/>
	</xsl:template>
	<xsl:template name="ctxsl:footer-cb">
		<xsl:call-template name="ctxsl:footer">
			<xsl:with-param name="ctxsl:structure">
				<a href="http://validator.w3.org/check/referer">HTML 4.01 Strict</a>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
