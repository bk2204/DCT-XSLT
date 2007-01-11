<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
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
	<xsl:template match="xhtml:body">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
				<xsl:attribute name="class">content</xsl:attribute>
				<xsl:apply-templates/>
			</xsl:element>
			<xsl:apply-templates select="xhtml:div[@class='article']/xhtml:div[@class = 'section' and position()=last()]" mode="nav-fixup"/>
			<xsl:call-template name="footer">
				<xsl:with-param name="structure">
					<a href="http://validator.w3.org/check/referer">HTML 4.01 Strict</a>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
