<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:ng="http://docbook.org/docbook-ng"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:cc="http://creativecommons.org/ns#"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	exclude-result-prefixes="db ng exsl ctxsl">
	<!--
	Items that are imported first have the lowest priority, followed by
	later imports, followed by this sheet.
	-->
	<xsl:template name="ctxsl:metadata-title">
		<xsl:param name="element"/>
		<xsl:choose>
			<xsl:when test=".//rdf:Description/dc:title">
				<xsl:copy-of select=".//rdf:Description/dc:title"/>
			</xsl:when>
			<xsl:when test="dc:title">
				<xsl:copy-of select="dc:title"/>
			</xsl:when>
			<xsl:when test="../title">
				<dc:title><xsl:value-of select="../title"/></dc:title>
			</xsl:when>
			<xsl:when test="title">
				<dc:title><xsl:value-of select="title"/></dc:title>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="dc:*[local-name()!='title']" mode="ctxsl:metadata">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template
		match="rdf:RDF|rdf:Description[@rdf:about='']|cc:Work[@rdf:about='']"
		mode="ctxsl:metadata">
		<xsl:if test="cc:license">
			<cc:license>
				<rdf:Alt>
					<xsl:for-each select="cc:license">
						<rdf:li>
							<xsl:value-of select="@rdf:resource" />
						</rdf:li>
					</xsl:for-each>
				</rdf:Alt>
			</cc:license>
		</xsl:if>
		<xsl:apply-templates mode="ctxsl:metadata"/>
	</xsl:template>
	<xsl:template match="cc:license" mode="ctxsl:metadata" />
	<xsl:template match="cc:Work" mode="ctxsl:metadata"/>
	<xsl:template match="*" mode="ctxsl:metadata"/>
	<xsl:template match="@*" mode="ctxsl:metadata">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template name="ctxsl:metadata">
		<xsl:param name="element"/>
		<rdf:RDF>
			<rdf:Description rdf:about="">
				<!--<xsl:apply-templates select="rdf:RDF/rdf:Description/" mode="ctxsl:metadata"/>-->
				<xsl:for-each select="$element/*">
					<xsl:if test="contains(name(.), 'info')">
						<xsl:call-template name="ctxsl:metadata-title">
							<xsl:with-param name="element" select="$element"/>
						</xsl:call-template>
						<xsl:apply-templates mode="ctxsl:metadata" />
					</xsl:if>
				</xsl:for-each>
			</rdf:Description>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
