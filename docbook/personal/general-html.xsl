<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
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
	<!--
	http://crustytoothpaste.ath.cx/rel/def/meta maps a document to its metadata.
	-->
	<xsl:template match="extendedlink/arc[@xlink:arcrole='http://crustytoothpaste.ath.cx/rel/def/meta']">
		<xsl:variable name="arcfrom"><xsl:value-of select="@xlink:from"/></xsl:variable>
		<xsl:variable name="arcto"><xsl:value-of select="@xlink:to"/></xsl:variable>
		<xsl:for-each select="../locator[string-length(@xlink:href)=0 and @xlink:label=$arcfrom]">
			<xsl:for-each select="../locator[@xlink:label=$arcto]">
				<!-- Your metadata should be of application/rdf+xml anyway. -->
				<xsl:element name="link" namespace="http://www.w3.org/1999/xhtml">
					<xsl:attribute name="rel">meta</xsl:attribute>
					<xsl:attribute name="type">application/rdf+xml</xsl:attribute>
					<xsl:attribute name="href"><xsl:value-of select="@xlink:href"/></xsl:attribute>
					<xsl:attribute name="title"><xsl:value-of select="@xlink:title"/></xsl:attribute>
				</xsl:element>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="extendedlink/arc" priority="-1">
		<xsl:message>Ignoring arc with xlink:arcrole <xsl:value-of select="@xlink:arcrole" />.</xsl:message>
	</xsl:template>
	<xsl:template name="user.head.content">
		<xsl:param name="node" select="." />
		<xsl:apply-templates select="/*/articleinfo/extendedlink" />
	</xsl:template>
	<xsl:template match="/*/articleinfo/extendedlink">
		<xsl:apply-templates select="arc" />
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
