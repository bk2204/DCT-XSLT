<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xi="http://www.w3.org/2003/XInclude"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:cc="http://creativecommons.org/ns#"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:saxon="http://icl.com/saxon"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="db xlink ctxsl xsl xi dc cc rdf saxon">
	<xsl:import href="../htmllib/0x89c-pstp.xsl" />
	<xsl:import href="../htmllib/format-xhtml-rdfa.xsl" />
	<xsl:output method="xml" encoding="UTF-8" indent="no"
		doctype-public="-//W3C//DTD XHTML+RDFa 1.0//EN"
		doctype-system="http://www.w3.org/MarkUp/DTD/xhtml-rdfa-1.dtd"/>
</xsl:stylesheet>
