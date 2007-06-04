<?xml version="1.0"?> 

<!-- Atom to RSS 1.0 Transformation, written by Rene Puls (rpuls@kcore.de) -->

<!-- Snownews filter command for this extension: "xsltproc /path/to/atom2rss -" -->

<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:atom="http://purl.org/atom/ns#"
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns="http://purl.org/rss/1.0/">

<xsl:output method="xml" indent="yes" cdata-section-elements="description" />

<xsl:template match="/">
	<xsl:apply-templates select="atom:feed" />
</xsl:template>

<xsl:template match="atom:feed">
	<rdf:RDF>
		<channel>
			<xsl:attribute name="rdf:about"><xsl:value-of select="atom:link[@rel='service.feed']/@href" /></xsl:attribute>
			<title><xsl:value-of select="normalize-space(atom:title)" /></title>
			<link><xsl:value-of select="atom:link[@type='text/html']/@href" /></link>
			<description><xsl:value-of select="normalize-space(atom:info)" /></description>
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
		<link><xsl:value-of select="atom:link[@type='text/html']/@href" /></link>
		<xsl:if test="atom:issued">
			<dc:date><xsl:value-of select="normalize-space(atom:issued)" /></dc:date>
		</xsl:if>
		<xsl:if test="atom:author">
			<dc:creator><xsl:value-of select="normalize-space(atom:author)" /></dc:creator>
		</xsl:if>
		
		<xsl:if test="atom:content">
			<description><xsl:value-of select="normalize-space(atom:content)" /></description>
		</xsl:if>
		<xsl:if test="not(atom:content) and atom:summary">
			<description><xsl:value-of select="normalize-space(atom:summary)" /></description>
		</xsl:if>
	</item>
</xsl:template>

</xsl:stylesheet>

