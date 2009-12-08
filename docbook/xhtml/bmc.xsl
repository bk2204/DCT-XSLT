<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
	Items that are imported first have the lowest priority, followed by
	later imports, followed by this sheet.
	-->
	<xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/xhtml/docbook.xsl" />
	<xsl:import href="../lib/base.xsl" />
	<xsl:import href="../htmllib/base.xsl" />
</xsl:stylesheet>
