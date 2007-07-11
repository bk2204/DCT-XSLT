<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	exclude-result-prefixes="db html ctxsl xlink"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="ctxsl:make-html-link">
		<xsl:param name="rel"/>
		<xsl:param name="type"/>
		<xsl:param name="href"/>
		<xsl:param name="title"/>
		<xsl:element name="link" namespace="http://www.w3.org/1999/xhtml">
			<xsl:attribute name="rel"><xsl:value-of select="$rel"/></xsl:attribute>
			<xsl:attribute name="type"><xsl:value-of select="$type"/></xsl:attribute>
			<xsl:attribute name="href"><xsl:value-of select="$href"/></xsl:attribute>
			<xsl:attribute name="title"><xsl:value-of select="$title"/></xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template name="ctxsl:map-extendedlink-arc">
		<xsl:param name="rel"/>
		<xsl:param name="type"/>
		<xsl:variable name="arcfrom"><xsl:value-of select="@xlink:from"/></xsl:variable>
		<xsl:variable name="arcto"><xsl:value-of select="@xlink:to"/></xsl:variable>
		<xsl:for-each select="../locator[string-length(@xlink:href)=0 and @xlink:label=$arcfrom]">
			<xsl:for-each select="../locator[@xlink:label=$arcto]">
				<!-- Your metadata should be of application/rdf+xml anyway. -->
				<xsl:call-template name="ctxsl:make-html-link">
					<xsl:with-param name="rel"><xsl:value-of select="$rel"/></xsl:with-param>
					<xsl:with-param name="type"><xsl:value-of select="$type"/></xsl:with-param>
					<xsl:with-param name="href"><xsl:value-of select="@xlink:href"/></xsl:with-param>
					<xsl:with-param name="title"><xsl:value-of select="@xlink:title"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="extendedlink/arc" priority="-1">
		<xsl:message>Ignoring arc with xlink:arcrole <xsl:value-of select="@xlink:arcrole" />.</xsl:message>
	</xsl:template>
	<xsl:template name="user.head.content">
		<xsl:param name="node" select="." />
		<xsl:apply-templates select="/*/articleinfo/extendedlink" />
		<xsl:apply-templates select="/*/partinfo/extendedlink" />
		<xsl:apply-templates select="/*/bookinfo/extendedlink" />
	</xsl:template>
	<xsl:template match="/*/articleinfo/extendedlink">
		<xsl:apply-templates select="arc" />
	</xsl:template>
	<xsl:template match="/*/partinfo/extendedlink">
		<xsl:apply-templates select="arc" />
	</xsl:template>
	<xsl:template match="/*/bookinfo/extendedlink">
		<xsl:apply-templates select="arc" />
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
