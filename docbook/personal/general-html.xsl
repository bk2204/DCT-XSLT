<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
	Items that are imported first have the lowest priority, followed by
	later imports, followed by this sheet.
	-->
	<xsl:import href="toc-fixup.xsl" />
	<!-- Don't use CSS attributes on items; we'll do it ourselves. -->
	<xsl:param name="css.decoration" select="0" />
	<!-- If we have an abstract, use it as the META description. -->
	<xsl:param name="generate.meta.abstract" select="1" />
	<!-- Try hard to make the HTML valid and pretty. -->
	<xsl:param name="make.valid.html" select="1" />
	<xsl:param name="html.cleanup" select="1" />
	<!-- Pass the role attribute through to the class attribute. -->
	<xsl:param name="emphasis.propagates.style" select="1" />
	<xsl:param name="para.propagates.style" select="1" />
	<xsl:param name="phrase.propagates.style" select="1" />
	<xsl:param name="entry.propagates.style" select="1" />
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
