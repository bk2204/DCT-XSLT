<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xsl">
	<xsl:template match="xhtml:link[@rel = 'stylesheet']">
		<xsl:element name="link" namespace="http://www.w3.org/1999/xhtml">
			<xsl:attribute name="rel"><xsl:text>stylesheet</xsl:text></xsl:attribute>
			<xsl:attribute name="title"><xsl:text>Default</xsl:text></xsl:attribute>
			<xsl:attribute name="type"><xsl:text>text/css</xsl:text></xsl:attribute>
			<xsl:copy-of select="@href"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="xhtml:br"/>
	<xsl:template match="xhtml:hr"/>
	<xsl:template match="xhtml:div[@class = 'footnotes']/xhtml:hr"/>
	<xsl:template match="xhtml:div[@class = 'article']/xhtml:div[@class = 'titlepage']//xhtml:h2[@class = 'title']">
		<xsl:element name="h1">
			<xsl:copy-of select="@class"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template name="footer">
		<xsl:param name="structure"/>
		<!-- Insert a footer. -->
		<xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
			<xsl:attribute name="id"><xsl:text>footer</xsl:text></xsl:attribute>
			<xsl:attribute name="class"><xsl:text>footer</xsl:text></xsl:attribute>
			<hr />
			<p>
				This page is <strong><span class="valid">valid</span><xsl:text> </xsl:text>
					<span class="structure"><xsl:copy-of select="$structure"/></span>
				</strong>
				and uses
				<strong><span class="valid">valid</span>
					<xsl:text> </xsl:text><a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a></strong>.
			</p>
		<xsl:element>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
