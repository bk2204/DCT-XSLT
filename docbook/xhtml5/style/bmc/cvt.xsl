<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xi="http://www.w3.org/2003/XInclude"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:cc="http://creativecommons.org/ns#"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:saxon="http://icl.com/saxon"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="db xlink ctxsl xsl xi xhtml dc cc rdf saxon">
  <!--
  Items that are imported first have the lowest priority, followed by
  later imports, followed by this sheet.
  -->
  <xsl:import href="../base/cvt.xsl" />
</xsl:stylesheet>
