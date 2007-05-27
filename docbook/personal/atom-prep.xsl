<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:dbx="http://docbook.org/ns/docbook"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="number" select="1000000"/>
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="dbx:book|dbx:part">
		<xsl:copy>
			<xsl:apply-templates select="dbx:info" />
			<xsl:for-each select=".//dbx:article">
				<xsl:sort select="dbx:info/dbx:date" lang="en" order="descending" />
				<xsl:sort select="dbx:info/dbx:title" lang="en" order="descending" />
				<xsl:if test="position()&lt;=$number">
					<xsl:apply-templates select="."/>
				</xsl:if>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
