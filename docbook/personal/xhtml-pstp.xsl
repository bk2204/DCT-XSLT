<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xsl"
	>
	<xsl:import href="../xhtml-pstp.xsl" />
	<xsl:output method="xml" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>
	<xsl:template match="xhtml:link[@rel = 'stylesheet']">
		<xsl:element name="link">
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
	<xsl:template match="xhtml:body">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:apply-templates/>
			<!-- Insert a footer. -->
			<div class="footer">
				<p>
					This page is <strong><span class="valid">valid</span><xsl:text> </xsl:text>
						<span class="structure">XHTML 1.0 Transitional,
							XHTML 1.0 Strict, <em>and</em><xsl:text>&#x0020;</xsl:text>
						<a href="http://validator.w3.org/check/referer">XHTML 1.1</a>,
						</span>
					</strong>
					and uses
					<strong><span class="valid">valid</span>
						<xsl:text> </xsl:text><a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a></strong>.
				</p>
			</div>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
