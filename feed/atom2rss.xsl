<?xml version="1.0"?>

<!--
Atom to RSS 1.0 Transformation, written by Rene Puls (rpuls@kcore.de)

Available under the GPLv2 (according to http://kiza.kcore.de/software/snownews/snowscripts/extensions?file=atom2rss
-->
<xsl:stylesheet version="1.0"
	exclude-result-prefixes="xsl atom xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:atom="http://www.w3.org/2005/Atom"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:content="http://purl.org/rss/1.0/modules/content/"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns="http://purl.org/rss/1.0/">

	<xsl:import href="conversion.xsl" />
	<xsl:output method="xml" indent="yes" cdata-section-elements="description" />

	<xsl:template match="/">
		<xsl:apply-templates select="atom:feed" />
	</xsl:template>

	<xsl:template match="atom:feed">
		<rdf:RDF>
			<channel>
				<xsl:attribute name="rdf:about">
					<xsl:value-of select="atom:link[@rel='self']/@href" />
				</xsl:attribute>
				<title><xsl:value-of select="normalize-space(atom:title)" /></title>
				<xsl:if test="atom:link[@rel='alternate']/@href">
					<link><xsl:value-of select="atom:link[@rel='alternate']/@href" /></link>
				</xsl:if>
				<xsl:if test="dc:description">
					<description><xsl:value-of select="normalize-space(dc:description)" /></description>
				</xsl:if>
				<xsl:apply-templates select="*" mode="metadata" />
				<items>
					<rdf:Seq>
						<xsl:apply-templates select="atom:entry" mode="rdfitem"/>
					</rdf:Seq>
				</items>
			</channel>
			<xsl:apply-templates select="atom:entry" mode="rssitem" />
		</rdf:RDF>
	</xsl:template>

	<xsl:template match="atom:entry" mode="rdfitem">
		<rdf:li>
			<xsl:attribute name="rdf:resource">
				<xsl:value-of select="normalize-space(atom:id)" />
			</xsl:attribute>
		</rdf:li>
	</xsl:template>

	<xsl:template match="atom:entry" mode="rssitem">
		<item>
			<xsl:attribute name="rdf:about">
				<xsl:value-of select="normalize-space(atom:id)" />
			</xsl:attribute>
			<title><xsl:value-of select="normalize-space(atom:title)" /></title>
			<link><xsl:value-of select="atom:link[@rel='alternate']/@href" /></link>
			<xsl:if test="atom:issued">
				<dc:date>
					<xsl:value-of select="normalize-space(atom:issued)" />
				</dc:date>
			</xsl:if>
			<xsl:apply-templates select="atom:author"/>
			<xsl:apply-templates select="*" mode="metadata" />
			<xsl:apply-templates select="atom:summary"/>
			<xsl:apply-templates select="atom:content" mode="description" />
			<xsl:if test="atom:content">
				<content:items>
					<rdf:Bag>
						<rdf:li>
							<xsl:apply-templates select="atom:content"/>
						</rdf:li>
					</rdf:Bag>
				</content:items>
			</xsl:if>
		</item>
	</xsl:template>

	<xsl:template match="atom:author">
		<dc:creator>
			<xsl:value-of select="normalize-space(./atom:name)" />
		</dc:creator>
	</xsl:template>

	<xsl:template match="atom:summary">
		<description>
			<xsl:value-of select="normalize-space(.)" />
		</description>
	</xsl:template>

	<xsl:template match="atom:content" mode="description">
		<description>
			<xsl:value-of select="string(.)" />
		</description>
	</xsl:template>

	<xsl:template match="atom:content[@type='xhtml']">
		<content:item>
			<content:format rdf:resource="http://www.w3.org/1999/xhtml" />
			<content:encoding
				rdf:resource="http://www.w3.org/TR/REC-xml#dt-wellformed" />
			<rdf:value rdf:parseType="Literal">
				<xsl:copy-of select="xhtml:div"/>
			</rdf:value>
		</content:item>
	</xsl:template>

	<xsl:template match="atom:content[@type='html']">
		<content:item>
			<content:format
				rdf:resource="http://www.isi.edu/in-notes/iana/assignments/media-types/text/html">
				<rdf:value>
					<xsl:apply-templates select="text()"/>
				</rdf:value>
			</content:format>
		</content:item>
	</xsl:template>

	<xsl:template match="atom:*"/>

	<xsl:template match="rdf:RDF" mode="metadata">
		<xsl:apply-templates select="*[@rdf:about='']/*" />
	</xsl:template>

</xsl:stylesheet>

