<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:date="http://exslt.org/dates-and-times"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:xi="http://www.w3.org/2001/XInclude"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:atom="http://www.w3.org/2005/Atom">
	<xsl:template match="node()|@*" mode="strip">
		<xsl:apply-templates select="@*|node()" mode="strip"/>
	</xsl:template>
	<!-- atom elements:
	feed
	entry
	content
	generator
	icon
	id
	link
	logo
	published
	rights
	source
	subtitle
	summary
	title
	updated
	-->
	<!-- In the rather simple subset of DocBook that is handled, the following conventions apply:
	article: one entry
	part: one section; a tag
	book: main page; a collection of sections
	-->
	<xsl:template match="db:title">
		<xsl:element name="title" namespace="http://www.w3.org/2005/Atom">
			<xsl:apply-templates select=".//text()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="db:person|db:org">
		<xsl:apply-templates select="db:personname|db:orgname"/>
	</xsl:template>
	<xsl:template match="db:personname|db:orgname">
		<xsl:element name="name" namespace="http://www.w3.org/2005/Atom">
			<xsl:apply-templates mode="person"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="db:email" mode="person">
		<xsl:element name="email" namespace="http://www.w3.org/2005/Atom">
			<xsl:apply-templates mode="strip"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="db:address//db:link" mode="person">
		<xsl:element name="uri" namespace="http://www.w3.org/2005/Atom">
			<xsl:apply-templates select="@xlink:href" mode="strip"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="db:author">
		<xsl:element name="author" namespace="http://www.w3.org/2005/Atom">
			<xsl:apply-templates select="db:personname|db:orgname"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="db:collab">
		<xsl:for-each select="db:personname|db:orgname|db:person|db:org">
			<xsl:element name="contributor" namespace="http://www.w3.org/2005/Atom">
				<xsl:apply-templates select="."/>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="db:pubdate">
		<xsl:element name="published" namespace="http://www.w3.org/2005/Atom">
			<xsl:apply-templates select="."/>
		</xsl:element>
	</xsl:template>
	<xsl:template name="atom-link">
		<xsl:param name="node" />
		<xsl:param name="rel">alternate</xsl:param>
		<xsl:element name="link" namespace="http://www.w3.org/2005/Atom">
			<xsl:attribute name="rel"><xsl:value-of select="$rel"/></xsl:attribute>
			<xsl:attribute name="href">
				<xsl:value-of select="@xlink:href[id(..)=id($node)]"/>
			</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="db:releaseinfo/db:link">
		<xsl:element name="id" namespace="http://www.w3.org/2005/Atom">
			<xsl:value-of select="@xlink:href"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="db:info">
			<xsl:if test="not(./db:date)">
				<xsl:element name="updated" namespace="http://www.w3.org/2005/Atom">
					<xsl:value-of select="date:date-time()"/>
				</xsl:element>
			</xsl:if>
			<xsl:apply-templates select="db:title|db:subtitle|db:date|db:releaseinfo"/>
			<xsl:copy-of select="dc:*"/>
	</xsl:template>
	<xsl:template match="db:date">
			<xsl:element name="updated" namespace="http://www.w3.org/2005/Atom">
				<xsl:apply-templates/>
			</xsl:element>
	</xsl:template>
	<xsl:template match="/">
		<xsl:element name="feed" namespace="http://www.w3.org/2005/Atom">
			<xsl:element name="generator" namespace="http://www.w3.org/2005/Atom">
				<xsl:attribute name="version">unreleased (pre-v1)</xsl:attribute>
				<xsl:text>Crusty Toothpaste xsl-sheets atom.xsl</xsl:text>
			</xsl:element>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="db:book">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="db:part">
		<!--
		<xsl:element name="category" namespace="http://www.w3.org/2005/Atom">
			<xsl:attribute name="term"><xsl:value-of select="@xml:id"/></xsl:attribute>
			<xsl:attribute name="label"><xsl:apply-templates select="db:title|db:info/db:title"/></xsl:attribute>
		</xsl:element>
		-->
		<xsl:choose>
			<xsl:when test="/db:part">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="db:*[local-name()!='info']"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="db:article">
		<xsl:variable name="title"><xsl:value-of select="db:title|db:info/db:title"/></xsl:variable>
		<xsl:element name="entry" namespace="http://www.w3.org/2005/Atom">
			<xsl:apply-templates select="db:title|db:info"/>
			<xsl:call-template name="atom-link">
				<xsl:with-param name="node"><xsl:value-of select="db:info/db:releaseinfo/db:link"/></xsl:with-param>
			</xsl:call-template>
			<xsl:element name="content" namespace="http://www.w3.org/2005/Atom">
				<xsl:choose>
					<xsl:when test="@xml:id">
						<xsl:attribute name="type">xhtml</xsl:attribute>
						<xsl:element name="include" namespace="http://www.w3.org/2001/XInclude">
							<xsl:attribute name="parse">xml</xsl:attribute>
							<xsl:attribute name="href">index.xhtml</xsl:attribute>
							<xsl:attribute name="xpointer">
								<xsl:text>element(</xsl:text>
								<xsl:value-of select="@xml:id" />
								<xsl:text>)</xsl:text>
							</xsl:attribute>
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="src"><xsl:apply-templates select="./db:info/db:releaseinfo/db:link"/></xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
