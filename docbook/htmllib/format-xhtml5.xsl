<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="ctxsl xsl">

	<xsl:import href="format-xhtml.xsl"/>

	<xsl:variable name="ctxsl:id-name">xml:id</xsl:variable>
	<xsl:variable name="ctxsl:id-ns">http://www.w3.org/XML/1998/namespace</xsl:variable>

	<xsl:template name="ctxsl:xhtml-version" />

	<xsl:template match="@border" mode="ctxsl:all-xhtml2xhtml"/>

	<xsl:template match="@id" mode="ctxsl:all-xhtml2xhtml">
		<xsl:attribute name="xml:id"
			namespace="http://www.w3.org/XML/1998/namespace">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>

	<xsl:template name="ctxsl:load-meta-links">
		<xsl:if test="count(//xhtml:head/xhtml:link[@rel='meta']) >= 1">
			<rdf:RDF>
				<rdf:Description rdf:about="">
					<xsl:for-each select="//xhtml:head/xhtml:link[@rel='meta']">
						<rdf:seeAlso rdf:resource="{@href}"/>
					</xsl:for-each>
				</rdf:Description>
			</rdf:RDF>
		</xsl:if>
	</xsl:template>

	<xsl:template match="xhtml:head/xhtml:link[@rel='meta']"
		mode="ctxsl:all-xhtml2xhtml"/>

	<xsl:template match="xhtml:head" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:apply-templates mode="ctxsl:all-xhtml2xhtml" />
			<xsl:call-template name="ctxsl:load-meta-links"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="xhtml:colgroup[@span][xhtml:col[@span]]"
		mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:apply-templates select="@*[name()!='span']|*"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="xhtml:th/xhtml:p" mode="ctxsl:all-xhtml2xhtml">
		<xsl:apply-templates select="node()"/>
	</xsl:template>

	<xsl:template name="ctxsl:footer-cb">
		<xsl:call-template name="ctxsl:footer">
			<xsl:with-param name="ctxsl:structure">
				<a href="http://validator.w3.org/check/referer">XHTML 5</a>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
