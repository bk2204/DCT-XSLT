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
	<xsl:param name="title.font.family" select="'Times'" />
	<xsl:param name="body.font.family" select="'Times'" />
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
