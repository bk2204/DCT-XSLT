<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	exclude-result-prefixes="db html ctxsl xlink"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../../misc/link-struct.xsl" />
	<xsl:template name="ctxsl:link-struct-callback">
		<xsl:param name="role"/>
		<xsl:param name="rel"/>
		<xsl:param name="type"/>
		<xsl:param name="href"/>
		<xsl:param name="title"/>
		<xsl:element name="link" namespace="http://www.w3.org/1999/xhtml">
			<xsl:attribute name="rel"><xsl:value-of select="$rel"/></xsl:attribute>
			<xsl:if test="string-length($type)!=0">
				<xsl:attribute name="type"><xsl:value-of select="$type"/></xsl:attribute>
			</xsl:if>
			<xsl:attribute name="href"><xsl:value-of select="$href"/></xsl:attribute>
			<xsl:attribute name="title"><xsl:value-of select="$title"/></xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="db:extendedlink/db:arc" priority="-1">
		<xsl:message>Ignoring arc with xlink:arcrole <xsl:value-of select="@xlink:arcrole" />.</xsl:message>
	</xsl:template>
	<xsl:template match="/db:*/db:articleinfo/db:extendedlink">
		<xsl:apply-templates select="db:arc" />
	</xsl:template>
	<xsl:template match="/db:*/db:partinfo/db:extendedlink">
		<xsl:apply-templates select="db:arc" />
	</xsl:template>
	<xsl:template match="/db:*/db:bookinfo/db:extendedlink">
		<xsl:apply-templates select="db:arc" />
	</xsl:template>
	<xsl:template match="/db:*/db:info/db:extendedlink">
		<xsl:apply-templates select="db:arc" />
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
