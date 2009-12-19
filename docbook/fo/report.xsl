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
	<xsl:import href="base.xsl" />
	<xsl:import href="lib/font-times.xsl" />
	<xsl:import href="lib/report-coverpage.xsl" />
	<!-- Put the author in the right place. -->
	<xsl:template match="db:bookinfo/db:author|db:info/db:author" mode="titlepage.mode" priority="2">
		<fo:block xsl:use-attribute-sets="ctxsl:titlepage-info-default">
			<xsl:call-template name="person.name"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="db:author" mode="titlepage.mode">
		<fo:block xsl:use-attribute-sets="ctxsl:titlepage-info-default">
			<xsl:call-template name="anchor"/>
			<xsl:call-template name="person.name"/>
			<xsl:if test="db:affiliation/db:orgname">
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="db:affiliation/db:orgname" mode="titlepage.mode"/>
			</xsl:if>
			<xsl:if test="db:email|db:affiliation/db:address/db:email">
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="(db:email|db:affiliation/db:address/db:email)[1]"/>
			</xsl:if>
		</fo:block>
	</xsl:template>

	<xsl:template name="footer.content" />
</xsl:stylesheet>
