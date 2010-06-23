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

	<xsl:template match="xh:link[@rel = 'stylesheet']" mode="ct:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:apply-templates select="@type|@rel|@href"/>
			<xsl:choose>
				<xsl:when test="@title">
					<xsl:copy-of select="@title"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="title">Default</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="xh:div/@style" mode="ct:all-xhtml2xhtml"/>
	<xsl:template match="xh:hr" mode="ct:all-xhtml2xhtml"/>
	<xsl:template match="xh:acronym" mode="ct:all-xhtml2xhtml">
		<xsl:apply-templates mode="ct:all-xhtml2xhtml"/>
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
					This page is <span class="valid">valid</span><xsl:text> </xsl:text>
						<span class="structure"><xsl:copy-of select="$ct:structure"/></span>
					and uses
					<span class="valid">valid</span>
					<xsl:text> </xsl:text><span class="style-structure"><a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a></span>.
				</p>
			</div>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
