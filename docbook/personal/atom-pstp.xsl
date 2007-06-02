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
	<xsl:template match="xhtml:div[@class='literallayout']">
		<xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
			<xsl:attribute name="xml:space">preserve</xsl:attribute>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
