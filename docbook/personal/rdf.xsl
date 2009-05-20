<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:cc="http://web.resource.org/cc/"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="uri"/>
	<xsl:param name="copyright"/>
	<xsl:template match="node()">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="db:title">
		<dc:title>
			<xsl:apply-templates select=".//text()"/>
		</dc:title>
	</xsl:template>
	<xsl:template name="copyright">
		<xsl:if test="string-length($copyright)!=0">
			<dc:rights>
				<cc:license>
					<xsl:attribute name="resource" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
						<xsl:value-of select="$copyright"/>
					</xsl:attribute>
				</cc:license>
			</dc:rights>
		</xsl:if>
	</xsl:template>
	<xsl:template match="/db:*">
		<xsl:apply-templates select="db:title|db:info/db:title"/>
	</xsl:template>
	<xsl:template match="/">
		<rdf:RDF>
			<rdf:Description>
				<xsl:attribute name="about" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
					<xsl:value-of select="$uri"/>
				</xsl:attribute>
				<xsl:apply-templates/>
			</rdf:Description>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
