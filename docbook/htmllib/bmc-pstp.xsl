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
	<xsl:namespace-alias stylesheet-prefix="xhtml" result-prefix="#default" />
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
	<xsl:template match="db:extendedlink" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="rdf:RDF" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:div[@class = 'footnotes']/xhtml:hr" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:div[@class = 'footnotes']/xhtml:br" mode="ctxsl:all-xhtml2xhtml"/>
	<xsl:template match="xhtml:acronym" mode="ctxsl:all-xhtml2xhtml">
		<xsl:apply-templates mode="ctxsl:all-xhtml2xhtml"/>
	</xsl:template>
	<xsl:template name="ctxsl:add-class">
		<xsl:param name="ctxsl:class"/>
			<xsl:attribute name="class"><xsl:value-of select="@class"/><xsl:text>&#x0020;</xsl:text><xsl:value-of select="$ctxsl:class"/></xsl:attribute>
			<xsl:apply-templates select="@*[not(name(.) = 'class')]" mode="ctxsl:all-xhtml2xhtml"/>
	</xsl:template>
	<xsl:template match="xhtml:p[@class='acknowledgements']" mode="ctxsl:all-xhtml2xhtml">
		<div class="acknowledgements">
			<xsl:apply-templates mode="ctxsl:all-xhtml2xhtml"/>
		</div>
	</xsl:template>
	<xsl:template match="xhtml:body/xhtml:div[not(@class = 'footer')]" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:call-template name="ctxsl:add-class">
				<xsl:with-param name="ctxsl:class"><xsl:text>toplevel</xsl:text></xsl:with-param>
			</xsl:call-template>
			<xsl:apply-templates select="xhtml:div[@class = 'titlepage']"
				mode="ctxsl:all-xhtml2xhtml"/>
			<xsl:apply-templates select="xhtml:div[@class = 'toc']"
				mode="ctxsl:all-xhtml2xhtml"/>
			<div id="main" class="flow">
				<xsl:apply-templates select="xhtml:*[not((@class = 'titlepage') or (@class = 'toc'))]"
					mode="ctxsl:all-xhtml2xhtml"/>
			</div>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="xhtml:*" mode="ctxsl:copy-parent-class">
		<xsl:copy>
			<xsl:call-template name="ctxsl:add-class">
				<xsl:with-param name="ctxsl:class"><xsl:value-of select="../@class"/></xsl:with-param>
			</xsl:call-template>
			<xsl:apply-templates select="node()" mode="ctxsl:all-xhtml2xhtml"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="xhtml:div[@class='literallayout' or @class='address']"
		mode="ctxsl:all-xhtml2xhtml">
		<xsl:apply-templates mode="ctxsl:copy-parent-class"/>
	</xsl:template>
	<xsl:template match="xhtml:body/xhtml:div[not(@class = 'footer')]/xhtml:div[@class = 'titlepage']" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:attribute name="id">header</xsl:attribute>
			<xsl:apply-templates select="@*|node()" mode="ctxsl:all-xhtml2xhtml" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="xhtml:div[@class and ./xhtml:div[@class = 'titlepage'] and not(local-name(..)='body')]" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:if test="xhtml:div[@class='titlepage']//xhtml:*[@class='title']/xhtml:a[@id]">
				<xsl:attribute name="id">
					<xsl:value-of select="xhtml:div[@class='titlepage']//xhtml:*[@class='title']/xhtml:a/@id" />
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="@*" mode="ctxsl:all-xhtml2xhtml"/>
			<xsl:apply-templates select="xhtml:div[@class = 'titlepage']" mode="ctxsl:all-xhtml2xhtml"/>
			<div class="flow">
				<xsl:apply-templates select="xhtml:*[not(@class = 'titlepage')]" mode="ctxsl:all-xhtml2xhtml"/>
			</div>
		</xsl:copy>
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
			<xsl:attribute name="id"><xsl:text>footer</xsl:text></xsl:attribute>
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
							select="//xhtml:head/rdf:RDF/cc:Work[@rdf:about = '']/cc:license">
							<xsl:variable name="uri" select="@rdf:resource" />
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
				<xsl:attribute name="id">
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
	<xsl:template match="xhtml:div[@class = 'colophon']" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:if test="not(@id)">
				<xsl:attribute name="id">
					<xsl:text>colophon</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<div class="titlepage">
				<xsl:apply-templates select="xhtml:*[@class = 'title']"
					mode="ctxsl:all-xhtml2xhtml"/>
			</div>
			<div class="flow">
				<xsl:apply-templates select="xhtml:*[not(@class = 'title')]"
					mode="ctxsl:all-xhtml2xhtml"/>
			</div>
		</xsl:copy>
	</xsl:template>
	<!--
	Dummy implementation of the footer callback.
	-->
	<xsl:template name="ctxsl:footer-cb"/>
</xsl:stylesheet>
