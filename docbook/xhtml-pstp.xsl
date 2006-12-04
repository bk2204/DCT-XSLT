<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xsl"
	>
	<xsl:output method="xml" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>
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
