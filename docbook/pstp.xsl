<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xsl">
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
	<xsl:template match="xhtml:meta"/>
	<xsl:template match="xhtml:h1/xhtml:a"/>
	<xsl:template match="xhtml:h2/xhtml:a"/>
	<xsl:template match="xhtml:h3/xhtml:a"/>
	<xsl:template match="xhtml:h4/xhtml:a"/>
	<xsl:template match="xhtml:h5/xhtml:a"/>
	<xsl:template match="xhtml:h6/xhtml:a"/>
	<xsl:template match="xhtml:ol/@type"/>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
