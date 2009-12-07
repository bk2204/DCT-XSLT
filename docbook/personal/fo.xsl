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
	<!-- Use standard PostScript fonts, just in case. -->
	<xsl:param name="body.start.indent" select="'0pt'" />
	<xsl:param name="header.rule" select="0" />
	<xsl:param name="footer.rule" select="0" />
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
