<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:atom="http://www.w3.org/2005/Atom">
	<xsl:template match="node()|@*" mode="strip">
		<xsl:apply-templates select="@*|node()"/>
	</xsl:template>
	<xsl:template match="*">
		<xsl:message>Not-so-silently ignoring unhandled tag <xsl:value-of select="name(.)"/>.</xsl:message>
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
			<xsl:apply-templates mode="strip"/>
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
	<xsl:template match="db:book">
	</xsl:template>
	<xsl:template match="db:part">
		<xsl:element name="category" namespace="http://www.w3.org/2005/Atom">
			<xsl:attribute name="term"><xsl:value-of select="@xml:id"/></xsl:attribute>
			<xsl:attribute name="label"><xsl:apply-templates select="db:title|db:info/db:title"/></xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="db:article">
	</xsl:template>
</xsl:stylesheet>
