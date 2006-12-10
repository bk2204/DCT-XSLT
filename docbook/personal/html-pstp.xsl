<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xsl">
	<xsl:import href="../html-pstp.xsl" />
	<xsl:import href="./pstp.xsl" />
	<xsl:output method="html"
		encoding="US-ASCII"
		indent="no"
		doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
		doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
	<xsl:namespace-alias stylesheet-prefix="xhtml" result-prefix="#default" />
	<xsl:template match="xhtml:body">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
			<xsl:call-template name="footer">
				<xsl:with-param name="structure">
					<a href="http://validator.w3.org/check/referer">HTML 4.01</a>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
