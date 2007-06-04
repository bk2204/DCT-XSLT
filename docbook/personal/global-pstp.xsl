<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xi="http://www.w3.org/2003/XInclude"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xsl xhtml ctxsl xi">
	<xsl:template match="node()|@*" mode="ctxsl:personal-xhtml-navfixup">
		<xsl:apply-templates mode="ctxsl:all-xhtml2xhtml"/>
	</xsl:template>
	<xsl:template match="xhtml:div[@class='article']/xhtml:div[@class = 'section' and position()=last()]" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="normalize-space(./xhtml:div[@class = 'titlepage']//xhtml:h2[@class = 'title']/text())='Site Map'">
					<!-- Eliminate a node if we would have already fixed it up. -->
					<xsl:message>Eliminating node not in nav-fixup mode.</xsl:message>
				</xsl:when>
				<xsl:otherwise>
					<!-- Don't eliminate useful nodes that haven't already been considered. -->
					<xsl:message>Not eliminating node.</xsl:message>
					<xsl:call-template name="ctxsl:add-class">
						<xsl:with-param name="ctxsl:class"><xsl:text>noninitial</xsl:text></xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="xhtml:div[@class='article']/xhtml:div[@class = 'section' and position()=last()]" mode="ctxsl:personal-xhtml-navfixup">
		<xsl:message>Running in nav-fixup mode.</xsl:message>
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="normalize-space(./xhtml:div[@class = 'titlepage']//xhtml:h2[@class = 'title']/text())='Site Map'">
					<!-- Fix up a sitemap. -->
					<xsl:message>Fixing up sitemap.</xsl:message>
					<xsl:call-template name="ctxsl:add-class">
						<xsl:with-param name="ctxsl:class"><xsl:text>navigation</xsl:text></xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<!-- Ignore an object that should already be handled. -->
					<xsl:message>Not hacking up object <xsl:value-of select="generate-id(.)"/>.</xsl:message>
					<!--<xsl:apply-templates select="@*|node()"/>-->
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
