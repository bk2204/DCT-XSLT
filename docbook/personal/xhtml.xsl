<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
	Items that are imported first have the lowest priority, followed by
	later imports, followed by this sheet.
	-->
	<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/xhtml/docbook.xsl" />
	<xsl:import href="general.xsl" />
	<xsl:import href="general-html.xsl" />
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
