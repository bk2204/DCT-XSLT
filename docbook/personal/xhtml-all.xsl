<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:exsl="http://exslt.org/common"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xsl">
	<xsl:import href="xhtml-pstp.xsl" />
	<xsl:import href="xhtml.xsl" />
	<xsl:output method="xml" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>
	<xsl:namespace-alias stylesheet-prefix="xhtml" result-prefix="#default" />
	<!-- Don't use this rule by default.  However, if this is the top-level
	stylesheet, then it will be used. -->
	<xsl:template match="/">
		<xsl:apply-templates mode="ctxsl:all-xhtml" />
	</xsl:template>
	<xsl:template match="/" mode="ctxsl:all-xhtml">
		<xsl:variable name="ctxsl:all-db2xhtml">
			<!-- Run the DocBook stylesheets. -->
			<xsl:apply-imports />
		</xsl:variable>
		<xsl:apply-imports select="exsl:node-set($ctxsl:process-all)" mode="ctxsl:all-xhtml2xhtml" />
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
