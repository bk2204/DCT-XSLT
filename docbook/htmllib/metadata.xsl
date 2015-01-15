<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	exclude-result-prefixes="db html ctxsl xlink"
	xmlns:cc="http://creativecommons.org/ns#"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Punt processing this until later. -->
	<xsl:template match="rdf:RDF">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="dcterms:license" mode="ctxsl:all-docbook2xhtml">
		<xsl:attribute name="rdf:resource"
			namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
			<xsl:value-of select="@rdf:resource|text()"/>
		</xsl:attribute>
	</xsl:template>
	<xsl:template name="user.head.content">
		<xsl:param name="node" select="." />
		<xsl:apply-templates select="/*/articleinfo/extendedlink" />
		<xsl:apply-templates select="/*/partinfo/extendedlink" />
		<xsl:apply-templates select="/*/bookinfo/extendedlink" />
		<xsl:apply-templates select="/db:*/db:info/db:extendedlink" />
		<xsl:apply-templates select="/*/articleinfo/rdf:RDF" />
		<xsl:apply-templates select="/*/partinfo/rdf:RDF" />
		<xsl:apply-templates select="/*/bookinfo/rdf:RDF" />
		<xsl:apply-templates select="/db:*/db:info/rdf:RDF" />
		<xsl:if test="/db:*/db:info/dc:*|/db:*/db:info/dcterms:*">
			<rdf:RDF>
				<rdf:Description rdf:about="">
					<xsl:copy-of select="/db:*/db:info/dc:*" />
					<xsl:copy-of
						select="/db:*/db:info/dcterms:*[local-name() != 'license']" />
					<xsl:choose>
						<xsl:when test="count(/db:*/db:info/dcterms:license) = 0" />
						<xsl:when test="count(/db:*/db:info/dcterms:license) = 1">
							<cc:license>
								<xsl:apply-templates select="/db:*/db:info/dcterms:license"
									mode="ctxsl:all-docbook2xhtml"/>
							</cc:license>
						</xsl:when>
						<xsl:otherwise>
							<cc:license>
								<rdf:Alt>
									<xsl:for-each select="/db:*/db:info/dcterms:license">
										<rdf:li>
											<xsl:apply-templates select="."
												mode="ctxsl:all-docbook2xhtml"/>
										</rdf:li>
									</xsl:for-each>
								</rdf:Alt>
							</cc:license>
						</xsl:otherwise>
					</xsl:choose>
				</rdf:Description>
			</rdf:RDF>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
