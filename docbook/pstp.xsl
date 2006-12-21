<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:exsl="http://exslt.org/common"
	exclude-result-prefixes="xsl exsl">
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@lang"/>
	<xsl:template match="@target"/>
	<xsl:template match="@width"/>
	<xsl:template match="@align"/>
	<xsl:template match="@clear"/>
	<!-- Get rid of empty divs. -->
	<xsl:template match="xhtml:div[not(@class) and not(@id)]]">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="xhtml:meta"/>
	<xsl:template match="xhtml:h1/xhtml:a"/>
	<xsl:template match="xhtml:h2/xhtml:a"/>
	<xsl:template match="xhtml:h3/xhtml:a"/>
	<xsl:template match="xhtml:h4/xhtml:a"/>
	<xsl:template match="xhtml:h5/xhtml:a"/>
	<xsl:template match="xhtml:h6/xhtml:a"/>
	<xsl:template match="xhtml:ol/@type"/>
	<!-- This idea comes thanks to Norman Walsh and the DocBook stylesheets. -->
	<xsl:template match="/">
		<xsl:variable name="nons">
			<xsl:apply-templates />
		</xsl:variable>
		<xsl:apply-templates select="exsl:node-set($nons)" mode="maybensnuke" />
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
