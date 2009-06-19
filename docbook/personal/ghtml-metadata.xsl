<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	exclude-result-prefixes="db html ctxsl xlink"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Punt processing this until later. -->
	<xsl:template match="rdf:RDF">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template name="user.head.content">
		<xsl:param name="node" select="." />
		<xsl:apply-templates select="/*/articleinfo/extendedlink" />
		<xsl:apply-templates select="/*/partinfo/extendedlink" />
		<xsl:apply-templates select="/*/bookinfo/extendedlink" />
		<xsl:apply-templates select="/db:*/db:info/db:extendedlink" />
		<xsl:apply-templates select="/*/articleinfo/rdf:RDF" />
		<xsl:apply-templates select="/*/partinfo/rdf:RDF" />
		<xsl:apply-templates select="/*/bookinfo/rdf:RDF" />
		<xsl:apply-templates select="/db:*/db:info/rdf:RDF" />
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
