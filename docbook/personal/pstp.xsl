<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xsl">
	<xsl:template match="xhtml:link[@rel = 'stylesheet']">
		<xsl:element name="link" namespace="http://www.w3.org/1999/xhtml">
			<xsl:attribute name="rel"><xsl:text>stylesheet</xsl:text></xsl:attribute>
			<xsl:attribute name="title"><xsl:text>Default</xsl:text></xsl:attribute>
			<xsl:attribute name="type"><xsl:text>text/css</xsl:text></xsl:attribute>
			<xsl:copy-of select="@href"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="xhtml:br"/>
	<xsl:template match="xhtml:hr"/>
	<xsl:template match="xhtml:div[@class = 'footnotes']/xhtml:hr"/>
	<xsl:template name="header">
		<xsl:param name="level"/>
		<xsl:element name="h{$level}" namespace="http://www.w3.org/1999/xhtml">
			<xsl:copy-of select="@class"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template name="add-class">
		<xsl:param name="class"/>
		<xsl:copy>
			<xsl:attribute name="class"><xsl:value-of select="@class"/><xsl:text>&#x0020;</xsl:text><xsl:value-of select="$class"/></xsl:attribute>
			<xsl:apply-templates select="@*[not(name(.) = 'class')]|node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- The colophon is special, so fix it up on its own. -->
	<xsl:template match="xhtml:body/xhtml:div/xhtml:div[@class = 'colophon']/xhtml:*[@class = 'title']">
		<xsl:call-template name="header">
			<xsl:with-param name="level" select="1"/>
		</xsl:call-template>
	</xsl:template>
	<!-- Fix up the divisions so that they have the proper header levels. -->
	<xsl:template match="xhtml:body/xhtml:div/xhtml:div[not(@class = 'titlepage')]/xhtml:*[@class = 'title']">
		<xsl:call-template name="header">
			<xsl:with-param name="level" select="1"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="xhtml:div[@class = 'article']/xhtml:div[@class = 'titlepage']//xhtml:h2[@class = 'title']">
		<xsl:call-template name="header">
			<xsl:with-param name="level" select="1"/>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="xhtml:body/xhtml:div[not(@class = 'footer')]">
		<xsl:call-template name="add-class">
			<xsl:with-param name="class"><xsl:text>toplevel</xsl:text></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="xhtml:body/xhtml:div/xhtml:div[not(@class = 'titlepage')]">
		<xsl:call-template name="add-class">
			<xsl:with-param name="class"><xsl:text>noninitial</xsl:text></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="node()|@*" mode="nav-fixup">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="xhtml:div[@class='article']/xhtml:div[@class = 'section' and position()=last()]">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="normalize-space(./xhtml:div[@class = 'titlepage']//xhtml:h2[@class = 'title']/text())='Site Map'">
					<!-- Eliminate a node if we would have already fixed it up. -->
					<xsl:message>Eliminating node not in nav-fixup mode.</xsl:message>
				</xsl:when>
				<xsl:otherwise>
					<!-- Don't eliminate useful nodes that haven't already been considered. -->
					<xsl:message>Not eliminating node.</xsl:message>
					<xsl:apply-templates select="@*|node()"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="xhtml:div[@class='article']/xhtml:div[@class = 'section' and position()=last()]" mode="nav-fixup">
		<xsl:message>Running in nav-fixup mode.</xsl:message>
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="normalize-space(./xhtml:div[@class = 'titlepage']//xhtml:h2[@class = 'title']/text())='Site Map'">
					<!-- Fix up a sitemap. -->
					<xsl:message>Fixing up sitemap.</xsl:message>
					<xsl:call-template name="add-class">
						<xsl:with-param name="class"><xsl:text>navigation</xsl:text></xsl:with-param>
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
	<xsl:template name="footer">
		<xsl:param name="structure"/>
		<!-- Insert a footer. -->
		<xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
			<xsl:attribute name="id"><xsl:text>footer</xsl:text></xsl:attribute>
			<xsl:attribute name="class"><xsl:text>footer</xsl:text></xsl:attribute>
			<hr />
			<p>
				This page is <strong><span class="valid">valid</span><xsl:text> </xsl:text>
					<span class="structure"><xsl:copy-of select="$structure"/></span>
				</strong>
				and uses
				<strong><span class="valid">valid</span>
					<xsl:text> </xsl:text><a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a></strong>.
			</p>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
