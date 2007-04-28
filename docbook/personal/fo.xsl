<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
	Items that are imported first have the lowest priority, followed by
	later imports, followed by this sheet.
	-->
	<xsl:import href="/usr/share/xml/docbook/stylesheet/nwalsh/fo/docbook.xsl" />
	<xsl:import href="general.xsl" />
	<!-- Use standard PostScript fonts, just in case. -->
	<xsl:param name="monospace.font.family" select="'Courier'" />
	<xsl:param name="sans.font.family" select="'Helvetica'" />
	<xsl:param name="title.font.family" select="'Helvetica'" />
	<xsl:param name="body.font.family" select="'Palatino'" />
	<!-- The text should be flush left in verbatim sections such as address. -->
	<xsl:attribute-set name="verbatim.properties">
		<xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
		<xsl:attribute name="space-before.optimum">1em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
		<xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
		<xsl:attribute name="space-after.optimum">1em</xsl:attribute>
		<xsl:attribute name="space-after.maximum">1.2em</xsl:attribute>
		<xsl:attribute name="hyphenate">false</xsl:attribute>
		<xsl:attribute name="text-align">start</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
