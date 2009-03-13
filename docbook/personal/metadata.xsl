<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:ng="http://docbook.org/docbook-ng"
  xmlns:db="http://docbook.org/ns/docbook"
	xmlns:x="adobe:ns:meta/"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	exclude-result-prefixes="db ng exsl ctxsl">
	<!--
	Items that are imported first have the lowest priority, followed by
	later imports, followed by this sheet.
	-->
	<xsl:template match="rdf:RDF" mode="ctxsl:metadata">
		<rdf:RDF>
			<xsl:choose>
				<xsl:when test="dc:title">
					<xsl:copy-of select="dc:title"/>
				</xsl:when>
				<xsl:when test="../title">
					<dc:title><xsl:value-of select="../title"/></dc:title>
				</xsl:when>
				<xsl:when test="../../title">
					<dc:title><xsl:value-of select="../../title"/></dc:title>
				</xsl:when>
			</xsl:choose>
			<xsl:copy>
				<xsl:apply-templates />
			</xsl:copy>
		</rdf:RDF>
	</xsl:template>
	<xsl:template name="ctxsl:metadata">
		<xsl:param name="element"/>
		<xsl:for-each select="$element/*">
			<xsl:if test="contains(name(.), 'info')">
				<xsl:if test="./rdf:RDF">
					<xsl:apply-templates select="./rdf:RDF" mode="ctxsl:metadata"/>
				</xsl:if>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
