<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
  version="1.0"
  xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="ctxsl xsl">

  <xsl:import href="format-xhtml.xsl"/>

  <xsl:template name="ctxsl:xhtml-version">
    <xsl:attribute name="version">XHTML+RDFa 1.0</xsl:attribute>
  </xsl:template>

  <xsl:template name="ctxsl:footer-cb">
    <xsl:call-template name="ctxsl:footer">
      <xsl:with-param name="ctxsl:structure">
        <a href="http://validator.w3.org/check/referer">XHTML+RDFa 1.0</a>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
