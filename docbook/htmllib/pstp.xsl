<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:exsl="http://exslt.org/common"
	exclude-result-prefixes="xsl exsl">
	<xsl:template match="node()|@*" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" mode="ctxsl:all-xhtml2xhtml"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="@lang" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="@xml:lang" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="@target" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="@width" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="@align" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="@clear" mode="ctxsl:all-xhtml2xhtml"/>
	<!-- Get rid of empty divs. -->
	<xsl:template match="xhtml:div[not(@class) and not(@id)]" mode="ctxsl:all-xhtml2xhtml">
		<xsl:apply-templates mode="ctxsl:all-xhtml2xhtml" />
	</xsl:template>
	<xsl:template match="xhtml:div[@class!='titlepage']" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:choose>
				<xsl:when test="xhtml:div[@class='titlepage']//xhtml:*[@class='title']/xhtml:a[@id]">
					<xsl:attribute name="id">
						<xsl:value-of select="xhtml:div[@class='titlepage']//xhtml:*[@class='title']/xhtml:a/@id" />
					</xsl:attribute>
					<xsl:apply-templates select="@*|node()" mode="ctxsl:all-xhtml2xhtml" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="@*|node()" mode="ctxsl:all-xhtml2xhtml"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="xhtml:meta" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:h1/xhtml:a" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:h2/xhtml:a" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:h3/xhtml:a" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:h4/xhtml:a" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:h5/xhtml:a" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:h6/xhtml:a" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:ol/@type" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:ul/@type" mode="ctxsl:all-xhtml2xhtml"/>
	<!--
	Apparently, table elements are not output in the correct namespace, so
	we need to fix that.  This might only be a problem with DocBook 5.
	-->
	<xsl:template match="table|thead|caption|td|tr|th|tbody" mode="ctxsl:all-xhtml2xhtml">
		<xsl:if test="namespace-uri(.)=''">
			<xsl:message>Broken null-namespace tag <xsl:value-of select="name(.)" /> fixed up.</xsl:message>
			<xsl:element name="{local-name(.)}" namespace="http://www.w3.org/1999/xhtml">
				<xsl:apply-templates select="@*|node()" mode="ctxsl:all-xhtml2xhtml"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<!-- This idea comes thanks to Norman Walsh and the DocBook stylesheets. -->
	<xsl:template match="/" mode="ctxsl:all-xhtml2xhtml">
		<xsl:variable name="ctxsl:nons">
			<xsl:apply-templates mode="ctxsl:all-xhtml2xhtml" />
		</xsl:variable>
		<xsl:apply-templates select="exsl:node-set($ctxsl:nons)" mode="ctxsl:maybensnuke" />
	</xsl:template>
</xsl:stylesheet>
