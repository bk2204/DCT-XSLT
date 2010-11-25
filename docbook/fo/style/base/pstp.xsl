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
	<xsl:import href="../../project.xsl"/>
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="xmp:CreatorTool">
		<xsl:copy>
			<xsl:value-of select="$ctxsl:project-id"/>
			<xsl:text> with Apache FOP</xsl:text>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
