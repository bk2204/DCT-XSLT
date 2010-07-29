<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:xl="http://www.w3.org/1999/xlink"
	xmlns:ct="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xi="http://www.w3.org/2003/XInclude"
	xmlns:xh="http://www.w3.org/1999/xhtml"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:cc="http://creativecommons.org/ns#"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="db xl ct xsl xi xh dc cc rdf">
	<xsl:import href="pstp.xsl"/>
	<xsl:import href="restructure.xsl"/>

	<!-- Valid values are "left", "right", and "". -->
	<xsl:param name="ct:logo-position">left</xsl:param>
	<xsl:param name="ct:logo-url">/branding/logo</xsl:param>

	<xsl:template match="xh:link[@rel = 'stylesheet']" mode="ct:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="@title">
					<xsl:copy-of select="@title"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="title">Default</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="@type|@rel|@href" mode="ct:all-xhtml2xhtml"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="xh:div/@style" mode="ct:all-xhtml2xhtml"/>
	<xsl:template match="xh:hr" mode="ct:all-xhtml2xhtml"/>
	<xsl:template match="xh:acronym" mode="ct:all-xhtml2xhtml">
		<xsl:apply-templates mode="ct:all-xhtml2xhtml"/>
	</xsl:template>

	<xsl:template match="xh:body/xh:div[not(@class = 'footer')]/xh:div[@class = 'titlepage']//xh:*[@class = 'title']"
		mode="ct:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:if test="$ct:logo-position = 'left'">
				<img src="{$ct:logo-url}" alt=""/>
			</xsl:if>
			<xsl:apply-templates select="node()" mode="ct:all-xhtml2xhtml"/>
			<xsl:if test="$ct:logo-position = 'right'">
				<img src="{$ct:logo-url}" alt=""/>
			</xsl:if>
		</xsl:copy>
	</xsl:template>

	<xsl:template name="ct:footer">
		<xsl:param name="ct:structure"/>
		<!-- Insert a footer. -->
		<xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
			<xsl:attribute name="id"><xsl:text>footer</xsl:text></xsl:attribute>
			<xsl:attribute name="class"><xsl:text>footer</xsl:text></xsl:attribute>
			<hr />
			<div class="flow">
				<p>
					<a href="/contact">1341 Castle Court #412, Houston, TX 77006</a> |
					<a href="/contact">+1 832 623 2791</a> |
					<span class="valid">Valid</span><xsl:text> </xsl:text>
					<span class="structure"><xsl:copy-of select="$ct:structure"/></span>
					and
					<span class="style-structure"><a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a></span>.
				</p>
			</div>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
