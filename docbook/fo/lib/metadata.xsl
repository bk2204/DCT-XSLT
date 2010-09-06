<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:ng="http://docbook.org/docbook-ng"
  xmlns:db="http://docbook.org/ns/docbook"
	xmlns:x="adobe:ns:meta/"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	exclude-result-prefixes="db ng exsl ctxsl">
	<!--
	Items that are imported first have the lowest priority, followed by
	later imports, followed by this sheet.
	-->
	<!--<xsl:output method="xml" indent="no"/>-->
	<xsl:import href="http://docbook.sourceforge.net/release/xsl-ns/current/fo/docbook.xsl" />
	<xsl:import href="../../lib/metadata.xsl" />

	<!-- Silence the normal Debian messages. -->
	<xsl:template name="root.messages" />
</xsl:stylesheet>
