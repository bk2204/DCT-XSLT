<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" indent="no"/>
	<xsl:template name="break">
		<xsl:text>.br&#x000a;</xsl:text>
	</xsl:template>
	<xsl:template name="newline">
		<xsl:text>&#x000a;</xsl:text>
	</xsl:template>
	<xsl:template name="insert-zwnj">
		<xsl:text>\&amp;</xsl:text>
	</xsl:template>
	<xsl:template name="page-setup">
		<xsl:text>'pl 11i
'po 0.5i
'll 7.5i
'de HD
'sp 0.5i
..
'de FO
'bp
..
'wh 0 HD
'wh -0.5i FO
</xsl:text>
	</xsl:template>
	<xsl:template name="emit-attributes-begin">
		<xsl:apply-templates select="ancestor-or-self::*/@font-family[1]"/>
		<xsl:apply-templates select="ancestor-or-self::*/@hyphenate[1]"/>
	</xsl:template>
	<xsl:template name="emit-attributes-end">
		<xsl:apply-templates select="ancestor::*/@font-family[1]"/>
		<xsl:apply-templates select="ancestor::*/@hyphenate[1]"/>
	</xsl:template>
	<xsl:template name="handle-group">
		<xsl:call-template name="emit-attributes-begin"/>
		<xsl:apply-templates select="node()"/>
		<xsl:call-template name="emit-attributes-end"/>
	</xsl:template>
	<xsl:template match="fo:root">
		<!-- Punt on layouts for now. -->
		<xsl:call-template name="page-setup"/>
		<xsl:apply-templates select="fo:page-sequence"/>
	</xsl:template>
	<xsl:template match="fo:page-sequence">
		<xsl:apply-templates select="fo:flow"/>
	</xsl:template>
	<xsl:template match="fo:flow">
		<xsl:apply-templates select="fo:block"/>
	</xsl:template>
	<xsl:template match="fo:block">
		<xsl:call-template name="break"/>
		<xsl:call-template name="handle-group"/>
	</xsl:template>
	<xsl:template match="fo:inline">
		<xsl:call-template name="handle-group"/>
	</xsl:template>
	<xsl:template match="text()">
		<xsl:if test="starts-with(normalize-space(.),'.')">
			<xsl:call-template name="insert-zwnj"/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="string(ancestor::*/@white-space-collapse[1])='false'">
				<xsl:value-of select="."/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="normalize-space(.)"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="local-name(..)!='ablock' and string-length(normalize-space(.))!=0">
			<xsl:call-template name="newline"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="@font-family">
		<xsl:text>'fam </xsl:text><xsl:value-of select="substring(.,1,1)"/>
		<xsl:call-template name="newline"/>
	</xsl:template>
	<xsl:template match="@hyphenate">
		<xsl:choose>
			<xsl:when test="string(.)!='true'">
				<xsl:text>'hy 0</xsl:text>
			</xsl:when>
			<xsl:when test="string(.)='true'">
				<xsl:text>'hy 1</xsl:text>
			</xsl:when>
		</xsl:choose>
		<xsl:call-template name="newline"/>
	</xsl:template>
	<xsl:template match="@font-weight">
		<xsl:choose>
			<xsl:when test="string(.)!='bold'">
				<xsl:text>'ft R</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>'ft B</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:call-template name="newline"/>
	</xsl:template>
	<xsl:template match="@*"/>
	<!--
		<xsl:message>Ignoring attribute <xsl:value-of select="local-name(.)"/>.</xsl:message>
	</xsl:template>-->
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
