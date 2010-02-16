<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:date="http://exslt.org/dates-and-times"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:xi="http://www.w3.org/2001/XInclude"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:cc="http://web.resource.org/cc/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns="http://www.w3.org/2005/Atom"
	exclude-result-prefixes="xsl xlink date db xi xhtml ctxsl">
	<xsl:import href="../../project.xsl" />
	<xsl:import href="../../misc/link-structure.xsl" />
	<xsl:output method="xml" encoding="UTF-8" indent="no" />
	<xsl:template match="node()|@*" mode="strip">
		<xsl:apply-templates select="@*|node()" mode="strip"/>
	</xsl:template>
	<!-- atom elements:
	feed
	entry
	content
	generator
	icon
	id
	link
	logo
	published
	rights
	source
	subtitle
	summary
	title
	updated
	-->
	<!-- In the rather simple subset of DocBook that is handled, the following conventions apply:
	article: one entry
	part: one section; a tag
	book: main page; a collection of sections
	-->
	<xsl:template match="node()|@*" mode="copy-through">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" mode="copy-through"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="dc:subject" mode="copy-through">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" mode="copy-through"/>
		</xsl:copy>
		<category>
			<xsl:attribute name="term">
				<xsl:value-of select="translate(normalize-space(text()),'ABCDEFGHIJKLMNOPQRSTUVWXYZ ','abcdefghijklmnopqrstuvwxyz-')"/>
			</xsl:attribute>
			<xsl:attribute name="label">
				<xsl:value-of select="text()"/>
			</xsl:attribute>
		</category>
	</xsl:template>
	<xsl:template match="db:para"/>
	<xsl:template match="db:preface"/>
	<xsl:template match="db:title">
		<title>
			<xsl:apply-templates select=".//text()"/>
		</title>
		<dc:title>
			<xsl:apply-templates select=".//text()"/>
		</dc:title>
	</xsl:template>
	<xsl:template match="db:subtitle">
		<subtitle>
			<xsl:apply-templates select=".//text()"/>
		</subtitle>
	</xsl:template>
	<xsl:template match="db:person|db:org">
		<xsl:apply-templates select="db:personname|db:orgname"/>
	</xsl:template>
	<xsl:template match="db:personname|db:orgname">
		<name>
			<xsl:apply-templates mode="person"/>
		</name>
	</xsl:template>
	<xsl:template match="db:email" mode="person">
		<email>
			<xsl:apply-templates mode="strip"/>
		</email>
	</xsl:template>
	<xsl:template match="db:address//db:link" mode="person">
		<uri>
			<xsl:apply-templates select="@xlink:href" mode="strip"/>
		</uri>
	</xsl:template>
	<xsl:template match="db:author">
		<author>
			<xsl:apply-templates select="db:personname|db:orgname"/>
		</author>
	</xsl:template>
	<xsl:template match="db:collab">
		<xsl:for-each select="db:personname|db:orgname|db:person|db:org">
			<contributor>
				<xsl:apply-templates select="."/>
			</contributor>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="db:pubdate">
		<published>
			<xsl:apply-templates select="."/>
		</published>
	</xsl:template>
	<xsl:template match="db:abstract">
		<dc:description>
			<xsl:apply-templates select="db:para[1]//text()"/>
		</dc:description>
	</xsl:template>
	<xsl:template name="emit-link">
		<xsl:param name="rel"/>
		<xsl:param name="href"/>
		<xsl:param name="title"/>
		<link>
			<xsl:attribute name="rel">
				<xsl:value-of select="$rel"/>
			</xsl:attribute>
			<xsl:attribute name="href">
				<xsl:value-of select="$href"/>
			</xsl:attribute>
			<xsl:attribute name="title">
				<xsl:value-of select="$title"/>
			</xsl:attribute>
		</link>
	</xsl:template>
	<xsl:template name="ctxsl:link-struct-callback">
		<xsl:param name="role"/>
		<xsl:param name="rel"/>
		<xsl:param name="type"/>
		<xsl:param name="href"/>
		<xsl:param name="title"/>
		<xsl:choose>
			<xsl:when test="$rel=
				'http://crustytoothpaste.ath.cx/rel/def/license'">
				<rdf:RDF>
					<cc:Work rdf:about="">
						<cc:license>
							<xsl:attribute
								namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
								name="rdf:resource">
								<xsl:value-of select="$href"/>
							</xsl:attribute>
						</cc:license>
					</cc:Work>
				</rdf:RDF>
			</xsl:when>
			<xsl:when test="starts-with($rel,
				'http://www.iana.org/assignments/relation/')">
				<xsl:call-template name="emit-link">
					<xsl:with-param name="rel">
						<xsl:value-of select="substring-after($rel,
							'http://www.iana.org/assignments/relation/')"/>
					</xsl:with-param>
					<xsl:with-param name="href">
						<xsl:value-of select="$href"/>
					</xsl:with-param>
					<xsl:with-param name="title">
						<xsl:value-of select="$title"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="emit-link">
					<xsl:with-param name="rel">
						<xsl:value-of select="$rel"/>
					</xsl:with-param>
					<xsl:with-param name="href">
						<xsl:value-of select="$href"/>
					</xsl:with-param>
					<xsl:with-param name="title">
						<xsl:value-of select="$title"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="db:releaseinfo/db:link">
		<xsl:choose>
			<xsl:when test="@xlink:arcrole"/>
			<xsl:otherwise>
				<id>
					<xsl:value-of select="@xlink:href"/>
				</id>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="db:extendedlink/db:arc[@xlink:arcrole='http://crustytoothpaste.ath.cx/rel/syndication/atom10']">
		<xsl:call-template name="ctxsl:map-extendedlink-arc">
			<xsl:with-param name="role">self</xsl:with-param>
			<xsl:with-param name="rel">self</xsl:with-param>
			<xsl:with-param name="type">application/atom+xml</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="db:extendedlink/db:arc[@xlink:arcrole!='http://crustytoothpaste.ath.cx/rel/syndication/atom10']">
		<xsl:call-template name="ctxsl:map-extendedlink-arc">
			<xsl:with-param name="role">
				<xsl:value-of select="@xlink:arcrole"/>
			</xsl:with-param>
			<xsl:with-param name="rel">
				<xsl:value-of select="@xlink:arcrole"/>
			</xsl:with-param>
			<xsl:with-param name="type">application/rdf+xml</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template match="db:releaseinfo/db:link" mode="article">
		<link rel="alternate">
			<xsl:attribute name="href">
				<xsl:value-of select="@xlink:href"/>
			</xsl:attribute>
		</link>
	</xsl:template>
	<xsl:template match="db:info">
			<xsl:if test="not(./db:date)">
				<updated>
					<xsl:value-of select="date:date-time()"/>
				</updated>
			</xsl:if>
			<xsl:apply-templates select="db:title|db:subtitle"/>
			<xsl:apply-templates select="db:author"/>
			<xsl:apply-templates select="db:date|db:releaseinfo"/>
			<xsl:apply-templates select="db:extendedlink/db:arc"/>
			<xsl:apply-templates select="db:abstract"/>
			<xsl:apply-templates select="dc:*" mode="copy-through"/>
	</xsl:template>
	<xsl:template match="db:date">
		<updated>
			<xsl:apply-templates/>
		</updated>
	</xsl:template>
	<xsl:template match="/">
		<feed>
			<generator>
				<xsl:attribute name="version">
					<xsl:value-of select="$ctxsl:project-version"/>
				</xsl:attribute>
				<xsl:value-of select="$ctxsl:project-name"/>
			</generator>
			<xsl:apply-templates/>
		</feed>
	</xsl:template>
	<xsl:template match="db:book">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="db:part">
		<!--
		<xsl:element name="category" namespace="http://www.w3.org/2005/Atom">
			<xsl:attribute name="term"><xsl:value-of select="@xml:id"/></xsl:attribute>
			<xsl:attribute name="label"><xsl:apply-templates select="db:title|db:info/db:title"/></xsl:attribute>
		</xsl:element>
		-->
		<xsl:choose>
			<xsl:when test="/db:part">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="db:*[local-name()!='info']"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="db:article">
		<xsl:variable name="title"><xsl:value-of select="db:title|db:info/db:title"/></xsl:variable>
		<entry>
			<xsl:apply-templates select="db:title|db:info"/>
			<xsl:apply-templates select="db:info/db:releaseinfo/db:link" mode="article"/>
			<content>
				<xsl:choose>
					<xsl:when test="@xml:id">
						<xsl:attribute name="type">xhtml</xsl:attribute>
						<div xmlns="http://www.w3.org/1999/xhtml">
							<xsl:element name="include" namespace="http://www.w3.org/2001/XInclude">
								<xsl:attribute name="parse">xml</xsl:attribute>
								<xsl:attribute name="href">index.xhtml</xsl:attribute>
								<xsl:attribute name="xpointer">
									<xsl:text>element(</xsl:text>
									<xsl:value-of select="@xml:id" />
									<xsl:text>)</xsl:text>
								</xsl:attribute>
							</xsl:element>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="src"><xsl:apply-templates select="./db:info/db:releaseinfo/db:link"/></xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			</content>
		</entry>
	</xsl:template>
</xsl:stylesheet>
