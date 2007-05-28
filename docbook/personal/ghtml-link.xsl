<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:html="http://www.w3.org/1999/xhtml"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
	Items that are imported first have the lowest priority, followed by
	later imports, followed by this sheet.
	-->
	<xsl:import href="ghtml-link-struct.xsl" />
	<!--
	http://crustytoothpaste.ath.cx/rel/def/meta maps a document to its metadata.
	-->
	<xsl:template match="extendedlink/arc[@xlink:arcrole='http://crustytoothpaste.ath.cx/rel/def/meta']">
		<!-- Your metadata should be of application/rdf+xml anyway. -->
		<xsl:call-template name="ctxsl:map-extendedlink-arc">
			<xsl:with-param name="rel">meta</xsl:with-param>
			<xsl:with-param name="type">application/rdf+xml</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
