<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://docbook.org/ns/docbook"
	xmlns:d="http://docbook.org/ns/docbook"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="d xsl">

	<xsl:template match="@*|node">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="d:*">
		<xsl:element namespace="http://docbook.org/ns/docbook"
			name="{local-name(.)}">
			<xsl:apply-templates select="@*|node()"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="d:title">
		<xsl:if test="text() != 'Untitled'">
			<title><xsl:apply-templates/></title>
		</xsl:if>
	</xsl:template>

	<xsl:template match="d:simpara">
		<para><xsl:apply-templates/></para>
	</xsl:template>

	<xsl:template match="d:article">
		<article>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates select="*[local-name()!='title']"/>
		</article>
	</xsl:template>

	<xsl:template match="d:author|d:date"/>
	<xsl:template match="@xml:space|@xml:lang"/>
	<xsl:template match="d:literallayout/@class"/>

	<xsl:template match="d:article/d:info">
		<info>
			<xsl:apply-templates select="@*|../d:title|d:title"/>
			<xsl:apply-templates select="d:*[local-name()!='title']"/>
		</info>
	</xsl:template>
</xsl:stylesheet>
