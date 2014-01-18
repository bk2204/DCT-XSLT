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
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="db xlink ctxsl xsl xi xhtml dc cc rdf">
	<xsl:import href="pstp.xsl"/>
	<xsl:import href="restructure.xsl"/>

	<xsl:param name="dry-run" select="0" />
	<xsl:param name="no-replace-stylesheet" select="0" />
	<xsl:template match="xhtml:link[@rel = 'stylesheet']" mode="ctxsl:all-xhtml2xhtml">
		<xsl:choose>
			<xsl:when test="$dry-run or $no-replace-stylesheet">
				<xsl:copy-of select="."/>
			</xsl:when>
			<xsl:otherwise>
				<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
				<link type="text/css" rel="stylesheet" href="/css/bootstrap/bootstrap.css"/>
				<link type="text/css" rel="stylesheet" href="/css/bootstrap/ct-blue.css"/>
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
	<xsl:template match="db:extendedlink" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="rdf:RDF" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:div[@class = 'footnotes']/xhtml:hr" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:div[@class = 'footnotes']/xhtml:br" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:acronym" mode="ctxsl:all-xhtml2xhtml">
		<xsl:apply-templates mode="ctxsl:all-xhtml2xhtml"/>
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
		<xsl:for-each select="../db:locator[string-length(@xlink:href)=0 and @xlink:label=$arcfrom]">
			<xsl:for-each select="../db:locator[@xlink:label=$arcto]">
				<xsl:call-template name="ctxsl:emit-license">
					<xsl:with-param name="href">
						<xsl:value-of select="@xlink:href"/>
					</xsl:with-param>
					<xsl:with-param name="title">
						<xsl:value-of select="@xlink:title"/>
					</xsl:with-param>
					<xsl:with-param name="position">
						<xsl:value-of select="position()"/>
					</xsl:with-param>
					<xsl:with-param name="last">
						<xsl:value-of select="last()"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="ctxsl:emit-license">
		<xsl:param name="href" />
		<xsl:param name="title" />
		<xsl:param name="position" />
		<xsl:param name="last" />
		<xsl:choose>
			<xsl:when test="($position=1) and ($last &gt; 1)">
				<xsl:text> your choice of </xsl:text>
			</xsl:when>
			<xsl:when test="$position=1"/>
			<xsl:when test="($position=$last) and ($last=2)">
				<xsl:text> or </xsl:text>
			</xsl:when>
			<xsl:when test="$position=$last">
				<xsl:text>, or </xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>, </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:element name="a" namespace="http://www.w3.org/1999/xhtml">
			<xsl:attribute name="rel">
				<xsl:text>license</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="href">
				<xsl:value-of select="$href"/>
			</xsl:attribute>
			<xsl:value-of select="$title"/>
		</xsl:element>
	</xsl:template>
	<xsl:template name="ctxsl:footer">
		<xsl:param name="ctxsl:structure"/>
		<!-- Insert a footer. -->
		<xsl:element name="div" namespace="http://www.w3.org/1999/xhtml">
			<xsl:attribute name="{$ctxsl:id-name}" namespace="{$ctxsl:id-ns}"><xsl:text>footer</xsl:text></xsl:attribute>
			<xsl:attribute name="class"><xsl:text>footer</xsl:text></xsl:attribute>
			<hr />
			<div class="flow">
				<p>
					This page is <span class="valid">valid</span><xsl:text> </xsl:text>
						<span class="structure"><xsl:copy-of select="$ctxsl:structure"/></span>
					and uses
					<span class="valid">valid</span>
					<xsl:text> </xsl:text><span class="style-structure"><a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a></span>.
					<xsl:if test="//xhtml:head/db:extendedlink/db:arc[@xlink:arcrole='http://crustytoothpaste.ath.cx/rel/def/license']">
						This page is licensed under
						<xsl:for-each
							select="//xhtml:head/db:extendedlink/db:arc[@xlink:arcrole='http://crustytoothpaste.ath.cx/rel/def/license']">
							<xsl:call-template name="ctxsl:emit-license-arc"/>
						</xsl:for-each>.
					</xsl:if>
					<xsl:if test="//xhtml:head/rdf:RDF/cc:Work[@rdf:about = '']/cc:license">
						This page is licensed under
						<xsl:for-each
							select="//xhtml:head/rdf:RDF/cc:Work[@rdf:about = '']/cc:license/rdf:Alt/rdf:li|//xhtml:head/rdf:RDF/cc:Work[@rdf:about = '']/cc:license[@rdf:resource]">
							<xsl:variable name="uri" select="@rdf:resource"/>
							<xsl:variable name="position" select="position()" />
							<xsl:variable name="last" select="last()" />
							<xsl:for-each
								select="//xhtml:head/rdf:RDF/cc:License[@rdf:about = $uri]">
								<xsl:call-template name="ctxsl:emit-license">
									<xsl:with-param name="href">
										<xsl:value-of select="$uri"/>
									</xsl:with-param>
									<xsl:with-param name="title">
										<xsl:value-of select="./dc:title//text()"/>
									</xsl:with-param>
									<xsl:with-param name="position">
										<xsl:value-of select="$position"/>
									</xsl:with-param>
									<xsl:with-param name="last">
										<xsl:value-of select="$last"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:for-each>
						</xsl:for-each>.
					</xsl:if>
				</p>
			</div>
		</xsl:element>
	</xsl:template>
	<xsl:template match="xhtml:div[@class and ./xhtml:div[@class = 'titlepage']//xhtml:a[@id = 'sidebar']]" mode="ctxsl:move-sidebar">
		<xsl:copy>
			<xsl:if test="xhtml:div[@class='titlepage']//xhtml:*[@class='title']/xhtml:a[@id]">
				<xsl:attribute name="{$ctxsl:id-name}" namespace="{$ctxsl:id-ns}">
					<xsl:value-of select="xhtml:div[@class='titlepage']//xhtml:*[@class='title']/xhtml:a/@id" />
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="@*" mode="ctxsl:all-xhtml2xhtml"/>
			<xsl:apply-templates select="xhtml:div[@class = 'titlepage']" mode="ctxsl:all-xhtml2xhtml"/>
			<xsl:apply-templates select="xhtml:div[@class = 'toc']" mode="ctxsl:all-xhtml2xhtml"/>
			<div class="flow">
				<xsl:apply-templates select="xhtml:*[not((@class = 'titlepage') or (@class = 'toc'))]" mode="ctxsl:all-xhtml2xhtml"/>
			</div>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="xhtml:div[@class and ./xhtml:div[@class = 'titlepage']//xhtml:a[@id = 'sidebar']]" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:body" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<div class="content">
				<xsl:apply-templates select="node()" mode="ctxsl:all-xhtml2xhtml"/>
			</div>
			<xsl:apply-templates select="//xhtml:div[@class and ./xhtml:div[@class = 'titlepage']//xhtml:a[@id = 'sidebar']]"
				mode="ctxsl:move-sidebar"/>
			<xsl:call-template name="ctxsl:footer-cb"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
