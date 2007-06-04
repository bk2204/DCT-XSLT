<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xsl">
	<xsl:import href="../html-pstp.xsl" />
	<xsl:import href="./pstp.xsl" />
	<xsl:output method="html"
		encoding="US-ASCII"
		indent="no"
		doctype-public="-//W3C//DTD HTML 4.01//EN"
		doctype-system="http://www.w3.org/TR/html4/strict.dtd"/>
	<xsl:namespace-alias stylesheet-prefix="xhtml" result-prefix="#default" />
	<xsl:template match="/">
		<xsl:apply-templates select="." mode="ctxsl:all-xhtml2xhtml"/>
	</xsl:template>
	<xsl:template match="xhtml:body" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
				<xsl:attribute name="class">content</xsl:attribute>
				<xsl:apply-templates mode="ctxsl:all-xhtml2xhtml"/>
			</xsl:element>
			<xsl:call-template name="ctxsl:footer">
				<xsl:with-param name="ctxsl:structure">
					<a href="http://validator.w3.org/check/referer">HTML 4.01 Strict</a>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
