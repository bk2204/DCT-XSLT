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
		<xsl:element name="title" namespace="http://purl.org/dc/elements/1.1/">
			<xsl:apply-templates select=".//text()"/>
		</xsl:element>
	</xsl:template>
	<xsl:template name="copyright">
		<xsl:if test="string-length($copyright)!=0">
			<xsl:element name="rights" namespace="http://purl.org/dc/elements/1.1/">
				<xsl:element name="License" namespace="http://web.resource.org/cc/">
					<xsl:attribute name="resource" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
						<xsl:value-of select="$copyright"/>
					</xsl:attribute>
				</xsl:element>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="/db:*">
		<xsl:apply-templates select="db:title|db:info"/>
	</xsl:template>
	<xsl:template match="/">
		<xsl:element name="RDF" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
			<xsl:element name="Description" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
				<xsl:attribute name="about" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
					<xsl:value-of select="$uri"/>
				</xsl:attribute>
				<xsl:apply-templates/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
