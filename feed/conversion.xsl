<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl atom xhtml rdf rss"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:atom="http://www.w3.org/2005/Atom"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:cc="http://web.resource.org/cc/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:content="http://purl.org/rss/1.0/modules/content/"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:slash="http://purl.org/rss/1.0/modules/slash/"
	xmlns:taxo="http://purl.org/rss/1.0/modules/taxonomy/"
	xmlns:syn="http://purl.org/rss/1.0/modules/syndication/"
	xmlns:admin="http://webns.net/mvcb/"
	xmlns:feedburner="http://rssnamespace.org/feedburner/ext/1.0"
	xmlns:rss="http://purl.org/rss/1.0/">

	<xsl:template match="node()|@*" mode="copy-through">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" mode="copy-through" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="dc:*|cc:*|syn:*|slash:*|taxo:*|admin:*|feedburner:*"
		mode="metadata">
		<xsl:apply-templates select="." mode="copy-through" />
	</xsl:template>

	<xsl:template match="dc:*|cc:*|syn:*|slash:*|taxo:*|admin:*|feedburner:*">
		<xsl:apply-templates select="." mode="copy-through" />
	</xsl:template>

	<xsl:template match="*" priority="-1">
		<xsl:apply-templates select="." mode="copy-through" />
	</xsl:template>

	<xsl:template match="rss:*|atom:*" mode="metadata" />
</xsl:stylesheet>

