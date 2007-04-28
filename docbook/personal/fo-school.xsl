<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
	Items that are imported first have the lowest priority, followed by
	later imports, followed by this sheet.
	-->
	<xsl:import href="fo.xsl" />
	<xsl:param name="header.rule" select="0" />
	<xsl:param name="footer.rule" select="0" />
	<xsl:param name="line-height" select="2.0" />
	<xsl:param name="body.start.indent">0pt</xsl:param>
	<xsl:param name="body.font.master">12</xsl:param>
	<xsl:param name="body.font.family" select="'Times'" />
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
