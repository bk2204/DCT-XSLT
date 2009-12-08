<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl xlink date xi db"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:date="http://exslt.org/dates-and-times"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:xi="http://www.w3.org/2001/XInclude"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:atom="http://www.w3.org/2005/Atom">
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="xhtml:div[@class='article']/xhtml:div[@class='titlepage']"/>
	<xsl:template match="atom:entry/atom:subtitle"/>
	<xsl:template match="xhtml:span[@class = 'indent']">
		<xsl:text>&#x09;</xsl:text>
		<xsl:apply-templates select="node()"/>
	</xsl:template>
</xsl:stylesheet>
