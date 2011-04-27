<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
	Items that are imported first have the lowest priority, followed by
	later imports, followed by this sheet.
	-->
	<xsl:import href="../base/cvt.xsl" />
	<xsl:import href="../../lib/font-times.xsl" />
	<xsl:import href="../../lib/report-coverpage.xsl" />

	<xsl:template name="footer.content" />

	<!-- This will inherit other attributes from the default definition. -->
	<xsl:attribute-set name="component.title.properties">
		<xsl:attribute name="text-align">inherit</xsl:attribute>
	</xsl:attribute-set>

	<xsl:template match="db:*" mode="ctxsl:inline">
		<xsl:apply-templates select="."/>
	</xsl:template>

	<!-- This prevents the generation of extra padding and spacing. -->
	<xsl:template match="db:para" mode="ctxsl:inline">
		<fo:block>
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template match="db:annotation[not(@annotates)]">
		<fo:block font-style="italic" space-before="0.5em">
			<xsl:apply-templates mode="ctxsl:inline"/>
		</fo:block>
	</xsl:template>

	<xsl:template match="db:dedication[parent::db:article]">
		<fo:block text-align="center" font-style="italic" space-before="0.5em">
			<xsl:apply-templates mode="ctxsl:inline"/>
		</fo:block>
	</xsl:template>

	<xsl:template match="db:acknowledgments[parent::db:article]">
		<fo:block font-style="italic" space-before="0.5em">
			<xsl:apply-templates mode="ctxsl:inline"/>
		</fo:block>
	</xsl:template>

</xsl:stylesheet>
