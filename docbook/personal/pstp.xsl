<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xi="http://www.w3.org/2003/XInclude"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xsl xhtml ctxsl xi">
	<xsl:param name="dry-run" select="0" />
	<xsl:param name="no-replace-stylesheet" select="0" />
	<xsl:template match="xhtml:link[@rel = 'stylesheet']" mode="ctxsl:all-xhtml2xhtml">
		<xsl:choose>
			<xsl:when test="$dry-run or $no-replace-stylesheet">
				<xsl:copy-of select="."/>
			</xsl:when>
			<xsl:otherwise>
				<link type="text/css" title="Default" rel="stylesheet" href="/css/docbook-xhtml/default.css"/>
				<link type="text/css" title="Simple" rel="alternate stylesheet" href="/css/docbook-xhtml/simple.css"/>
				<link type="text/css" title="Complexspiral" rel="alternate stylesheet" href="/css/docbook-xhtml/complexspiral.css"/>
				<link type="text/css" title="Water" rel="alternate stylesheet" href="/css/docbook-xhtml/water.css"/>
				<!--
				<link type="text/css" title="Highest Good" rel="alternate stylesheet" href="http://crustytoothpaste.ath.cx/css/docbook-xhtml/highest-good.css"/>
				<link type="text/css" title="Elegant Blue" rel="alternate stylesheet" href="http://crustytoothpaste.ath.cx/css/docbook-xhtml/elegant-blue.css"/>
				<link type="text/css" title="Subtle" rel="alternate stylesheet" href="http://crustytoothpaste.ath.cx/css/docbook-xhtml/subtle.css"/>
				-->
				<link type="text/css" title="New (testing only)" rel="alternate stylesheet" href="/css/docbook-xhtml/new.css"/>
			</xsl:otherwise>
		</xsl:choose>
		<!--
		<xi:include href="stylesheet.xml" parse="xml"
			xpointer="xmlns(sht=http://crustytoothpaste.ath.cx/ns/stylesheet)xpointer(sht:result/*)">
			<xi:fallback><xsl:message terminate="yes">Can't XInclude stylesheet list whilst processing</xsl:message></xi:fallback>
		</xi:include>
		-->
	</xsl:template>
	<xsl:template match="xhtml:div/@style" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="@xml:space" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:hr" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="extendedlink" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:div[@class = 'footnotes']/xhtml:hr" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:div[@class = 'footnotes']/xhtml:br" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template name="ctxsl:add-class">
		<xsl:param name="ctxsl:class"/>
		<xsl:copy>
			<xsl:attribute name="class"><xsl:value-of select="@class"/><xsl:text>&#x0020;</xsl:text><xsl:value-of select="$ctxsl:class"/></xsl:attribute>
			<xsl:apply-templates select="@*[not(name(.) = 'class')]|node()" mode="ctxsl:all-xhtml2xhtml"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="xhtml:body/xhtml:div[not(@class = 'footer')]" mode="ctxsl:all-xhtml2xhtml">
		<xsl:call-template name="ctxsl:add-class">
			<xsl:with-param name="ctxsl:class"><xsl:text>toplevel</xsl:text></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="xhtml:*" mode="ctxsl:copy-parent-class">
		<xsl:call-template name="ctxsl:add-class">
			<xsl:with-param name="ctxsl:class"><xsl:value-of select="../@class"/></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="xhtml:div[@class='literallayout' or @class='address']"
		mode="ctxsl:all-xhtml2xhtml">
		<xsl:apply-templates mode="ctxsl:copy-parent-class"/>
	</xsl:template>
	<!--
	<xsl:template match="xhtml:body/xhtml:div/xhtml:div[not(@class = 'titlepage')]" mode="ctxsl:all-xhtml2xhtml">
		<xsl:call-template name="ctxsl:add-class">
			<xsl:with-param name="ctxsl:class"><xsl:text>noninitial</xsl:text></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	-->
	<xsl:template name="ctxsl:emit-license-arc">
		<xsl:variable name="arcfrom"><xsl:value-of select="@xlink:from"/></xsl:variable>
		<xsl:variable name="arcto"><xsl:value-of select="@xlink:to"/></xsl:variable>
		<xsl:for-each select="../locator[string-length(@xlink:href)=0 and @xlink:label=$arcfrom]">
			<xsl:for-each select="../locator[@xlink:label=$arcto]">
				<xsl:choose>
					<xsl:when test="position()=1"/>
					<xsl:when test="position()=last()">
						<xsl:text>, or </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>, </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:element name="a" namespace="http://www.w3.org/1999/xhtml">
					<xsl:attribute name="href">
						<xsl:value-of select="@xlink:href"/>
					</xsl:attribute>
					<xsl:value-of select="@xlink:title"/>
				</xsl:element>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="ctxsl:footer">
		<xsl:param name="ctxsl:structure"/>
		<!-- Insert a footer. -->
		<xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
			<xsl:attribute name="id"><xsl:text>footer</xsl:text></xsl:attribute>
			<xsl:attribute name="class"><xsl:text>footer</xsl:text></xsl:attribute>
			<hr />
			<p>
				This page is <span class="valid">valid</span><xsl:text> </xsl:text>
					<span class="structure"><xsl:copy-of select="$ctxsl:structure"/></span>
				and uses
				<span class="valid">valid</span>
				<xsl:text> </xsl:text><span class="style-structure"><a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a></span>.
				<xsl:if test="//xhtml:head/extendedlink/arc[@xlink:arcrole='http://crustytoothpaste.ath.cx/rel/def/license']">
					This page is licensed under
					<xsl:for-each
						select="//xhtml:head/extendedlink/arc[@xlink:arcrole='http://crustytoothpaste.ath.cx/rel/def/license']">
						<xsl:call-template name="ctxsl:emit-license-arc"/>
					</xsl:for-each>.
				</xsl:if>
			</p>
		</xsl:element>
	</xsl:template>
	<xsl:template match="xhtml:body" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
				<xsl:attribute name="class">content</xsl:attribute>
				<xsl:apply-templates mode="ctxsl:all-xhtml2xhtml"/>
			</xsl:element>
			<xsl:call-template name="ctxsl:footer-cb"/>
		</xsl:copy>
	</xsl:template>
	<!--
	Dummy implementation of the footer callback.
	-->
	<xsl:template name="ctxsl:footer-cb"/>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
