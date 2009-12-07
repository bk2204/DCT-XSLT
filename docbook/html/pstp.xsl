<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:exsl="http://exslt.org/common"
	exclude-result-prefixes="xsl exsl">
	<xsl:import href="../htmllib/pstp.xsl" />
	<xsl:output method="html"
		encoding="US-ASCII"
		indent="no"
		doctype-public="-//W3C//DTD HTML 4.01//EN"
		doctype-system="http://www.w3.org/TR/html4/strict.dtd"/>
	<xsl:template match="@*[name(.)='lang']" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="*" mode="ctxsl:maybensnuke">
		<xsl:choose>
			<xsl:when test="self::xhtml:*">
				<xsl:element name="{local-name(.)}">
					<!-- We have to punt on xml:space="preserve". -->
					<xsl:copy-of select="@*[not(name(.) = 'xml:id') and not(name(.) = 'xml:space')]" />
					<xsl:apply-templates mode="ctxsl:maybensnuke" />
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message>Not in the XHTML namespace!</xsl:message>
				<xsl:message>Tag is <xsl:value-of select="name(.)" />.</xsl:message>
				<xsl:copy>
					<xsl:copy-of select="@*[not(name(.) = 'xml:id')]" />
					<xsl:apply-templates mode="ctxsl:maybensnuke" />
				</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
