<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:xmp="adobe:ns:meta/"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="strip-markup.xsl" />
	<xsl:output method="text" encoding="UTF-8" />

	<!--
	Ignore the output of certain metadata elements, since metadata is not usually
	counted in word counts.
	-->
	<xsl:template match="db:info"/>
	<xsl:template match="rdf:RDF"/>
	<xsl:template match="xmp:xmpmeta"/>
</xsl:stylesheet>
