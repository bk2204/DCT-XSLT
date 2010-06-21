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
	<xsl:import href="pstp.xsl" />
	<xsl:import href="../htmllib/bmc-pstp.xsl" />
	<xsl:output method="xml" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD XHTML+RDFa 1.0//EN" doctype-system="http://www.w3.org/MarkUp/DTD/xhtml-rdfa-1.dtd"/>
	<xsl:template match="/">
		<xsl:apply-templates select="." mode="ctxsl:all-xhtml2xhtml"/>
	</xsl:template>
	<xsl:template name="ctxsl:xhtml-version">
		<xsl:attribute name="version">XHTML+RDFa 1.0</xsl:attribute>
	</xsl:template>
	<xsl:template name="ctxsl:footer-cb">
		<xsl:call-template name="ctxsl:footer">
			<xsl:with-param name="ctxsl:structure">
				<a href="http://validator.w3.org/check/referer">XHTML+RDFa 1.0</a>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
