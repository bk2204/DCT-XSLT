<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xsl">
	<xsl:import href="../xhtml-pstp.xsl" />
	<xsl:import href="./pstp.xsl" />
	<xsl:output method="xml" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>
	<xsl:namespace-alias stylesheet-prefix="xhtml" result-prefix="#default" />
	<xsl:template match="/">
		<xsl:apply-templates select="." mode="ctxsl:all-xhtml2xhtml"/>
	</xsl:template>
	<xsl:template name="ctxsl:footer-cb">
		<xsl:call-template name="ctxsl:footer">
			<xsl:with-param name="ctxsl:structure">
				XHTML 1.0 Transitional, XHTML 1.0 Strict, <em>and</em><xsl:text>&#x0020;</xsl:text> <a href="http://validator.w3.org/check/referer">XHTML 1.1</a>,
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
