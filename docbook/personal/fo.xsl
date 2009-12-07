<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
	Items that are imported first have the lowest priority, followed by
	later imports, followed by this sheet.
	-->
	<xsl:import href="lib/fo-metadata.xsl" />
	<xsl:import href="lib/fo-poetry.xsl" />
	<xsl:import href="lib/general.xsl" />
	<xsl:import href="lib/fo-font-default.xsl" />
	<xsl:import href="lib/fo-base.xsl" />
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
