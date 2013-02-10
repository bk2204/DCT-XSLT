<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xi="http://www.w3.org/2003/XInclude"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:xmp="http://ns.adobe.com/xap/1.0/"
	exclude-result-prefixes="db xlink xsl xhtml ctxsl xi">
	<xsl:import href="../../../../project.xsl"/>
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="xmp:CreatorTool">
		<xsl:copy>
			<xsl:value-of select="$ctxsl:project-id-short"/>
		</xsl:copy>
	</xsl:template>

	<!--
			 Poppler ignores all sections with empty titles.  As a workaround,
			 generate a title with a single U+200B (ZERO WIDTH SPACE) to fix this
			 problem.
	-->
	<xsl:template match="fo:bookmark-title[string-length(text())=0]">
		<fo:bookmark-title>&#x200b;</fo:bookmark-title>
	</xsl:template>
</xsl:stylesheet>
