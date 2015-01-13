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

	<xsl:variable name="ctxsl:id-name">id</xsl:variable>
	<xsl:variable name="ctxsl:id-ns"/>

	<xsl:template name="ctxsl:xhtml-version" />

	<xsl:template match="@border" mode="ctxsl:all-xhtml2xhtml"/>

	<xsl:template name="ctxsl:load-meta-links">
		<xsl:if test="count(//xhtml:head/xhtml:link[@rel='meta']) >= 1">
			<rdf:Description rdf:about="">
				<xsl:for-each select="//xhtml:head/xhtml:link[@rel='meta']">
					<rdf:seeAlso rdf:resource="{@href}"/>
				</xsl:for-each>
			</rdf:Description>
		</xsl:if>
	</xsl:template>

	<xsl:template name="ctxsl:create-metadata">
		<xsl:if test="//xhtml:head/rdf:RDF">
			<xsl:processing-instruction name="xpacket"
				>begin="﻿" id="W5M0MpCehiHzreSzNTczkc9d"</xsl:processing-instruction>
			<!-- Emit the namespace here to ensure the XMP is self-contained. -->
			<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
				<xsl:copy-of
					select="//xhtml:head/rdf:RDF/rdf:Description[@rdf:about = '']" />
			</rdf:RDF>
			<xsl:processing-instruction name="xpacket"
				>end="w"</xsl:processing-instruction>
		</xsl:if>
		<xsl:if test="
			(count(//xhtml:head/xhtml:link[@rel='meta']) >= 1) or
			//xhtml:head/rdf:RDF/*[name(.) != 'rdf:Description'] or
			//xhtml:head/rdf:RDF/rdf:Description[not(@rdf:about = '')]">
			<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
				<!--
					load-meta-links has to go here because Adobe's XMP library and
					Exempi freak out if they see multiple rdf:seeAlso elements.
				-->
				<xsl:call-template name="ctxsl:load-meta-links"/>
				<xsl:copy-of
					select="//xhtml:head/rdf:RDF/*[name(.) != 'rdf:Description']|
					//xhtml:head/rdf:RDF/rdf:Description[not(@rdf:about = '')]" />
			</rdf:RDF>
		</xsl:if>
	</xsl:template>

	<xsl:template match="xhtml:head/xhtml:link[@rel='meta']"
		mode="ctxsl:all-xhtml2xhtml"/>

	<xsl:template match="rdf:RDF" mode="ctxsl:all-xhtml2xhtml" />

	<xsl:template name="ctxsl:insert-xml-id-js" />

	<xsl:template match="xhtml:head" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:apply-templates mode="ctxsl:all-xhtml2xhtml" />
			<xsl:call-template name="ctxsl:create-metadata" />
			<xsl:call-template name="ctxsl:insert-xml-id-js"/>
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

	<xsl:template match="xhtml:acronym">
		<abbr>
			<xsl:copy>
				<xsl:apply-templates select="@*|node()"/>
			</xsl:copy>
		</abbr>
	</xsl:template>

	<xsl:template match="@cellspacing|@cellpadding|@summary"/>

	<xsl:template name="ctxsl:footer-cb">
		<xsl:call-template name="ctxsl:footer">
			<xsl:with-param name="ctxsl:structure">
				<a href="http://validator.w3.org/check/referer">XHTML 5</a>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
