<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xi="http://www.w3.org/2003/XInclude"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:cc="http://creativecommons.org/ns#"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:saxon="http://icl.com/saxon"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="db xlink ctxsl xsl xi xhtml dc cc rdf saxon">
	<!--
	Items that are imported first have the lowest priority, followed by
	later imports, followed by this sheet.
	-->
	<xsl:import href="link.xsl" />
	<xsl:import href="metadata.xsl" />
	<xsl:import href="poetry.xsl" />
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
</xsl:stylesheet>
