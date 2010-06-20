<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
	Items that are imported first have the lowest priority, followed by
	later imports, followed by this sheet.
	-->
	<xsl:import href="lib/metadata.xsl" />
	<xsl:import href="lib/poetry.xsl" />
	<xsl:import href="../lib/base.xsl" />
	<xsl:import href="lib/fixup.xsl" />
	<xsl:import href="lib/font-default.xsl" />
	<xsl:import href="lib/base.xsl" />
</xsl:stylesheet>
