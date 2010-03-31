<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:date="http://exslt.org/dates-and-times"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:xi="http://www.w3.org/2001/XInclude"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:atom="http://www.w3.org/2005/Atom"
	xmlns="http://www.w3.org/2005/Atom"
	exclude-result-prefixes="xsl xlink date db xi xhtml xsi atom">
	<xsl:output method="xml" encoding="UTF-8" indent="no" />
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
  </xsl:template>
  <!--
  This removes the xmlns:xsi namespace node that is imported by the XHTML DTD.
  -->
  <xsl:template match="xhtml:*">
    <xsl:element name="{local-name()}" namespace="{namespace-uri()}">
			<xsl:apply-templates select="@*|node()"/>
    </xsl:element>
  </xsl:template>
	<xsl:template match="xhtml:div[@class='article']/xhtml:div[@class='titlepage']"/>
	<xsl:template match="atom:entry/atom:subtitle"/>
	<xsl:template match="xhtml:span[@class = 'indent']">
		<xsl:text>&#x09;</xsl:text>
		<xsl:apply-templates select="node()"/>
	</xsl:template>
</xsl:stylesheet>
