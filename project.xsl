<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  exclude-result-prefixes="xsl ctxsl">
  <xsl:param name="ctxsl:project-name">DCT XSLT</xsl:param>
  <xsl:param name="ctxsl:project-uri">https://github.com/bk2204/DCT-XSLT</xsl:param>
  <xsl:param name="ctxsl:project-version">unreleased (v5-pre)</xsl:param>
  <xsl:param name="ctxsl:project-id-short">
    <xsl:value-of select="$ctxsl:project-name"/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="$ctxsl:project-version"/>
  </xsl:param>
  <xsl:param name="ctxsl:project-id">
    <xsl:value-of select="$ctxsl:project-id-short"/>
    <xsl:if test="string-length($ctxsl:project-uri) != 0">
      <xsl:text> (</xsl:text>
      <xsl:value-of select="$ctxsl:project-uri"/>
      <xsl:text>)</xsl:text>
    </xsl:if>
  </xsl:param>
</xsl:stylesheet>
