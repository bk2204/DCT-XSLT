<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
  version="1.0"
  xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xh="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="ctxsl xsl xh">

  <xsl:variable name="ctxsl:id-name">id</xsl:variable>
  <xsl:variable name="ctxsl:id-ns"></xsl:variable>

  <xsl:template name="ctxsl:xhtml-version"/>

  <xsl:template name="ctxsl:footer-cb">
    <xsl:call-template name="ctxsl:footer">
      <xsl:with-param name="ctxsl:structure">
        <a href="http://validator.w3.org/check/referer">HTML 5</a>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates select="." mode="ctxsl:all-xhtml2xhtml"/>
  </xsl:template>

  <xsl:template match="@*[name(.)='lang']" mode="ctxsl:all-xhtml2xhtml">
    <xsl:copy-of select="." />
  </xsl:template>

  <xsl:template match="*" mode="ctxsl:maybensnuke">
    <xsl:choose>
      <xsl:when test="self::xh:* or self::*[namespace-uri() = '']">
        <xsl:element name="{local-name(.)}">
          <!-- We have to punt on xml:space="preserve". -->
          <xsl:copy-of select="@*[not(name(.) = 'xml:id') and not(name(.) = 'xml:space')]" />
          <xsl:apply-templates mode="ctxsl:maybensnuke" />
        </xsl:element>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>Not in the XHTML namespace!</xsl:message>
        <xsl:message>Tag is <xsl:value-of select="name(.)" />.</xsl:message>
        <xsl:copy>
          <xsl:copy-of select="@*[not(name(.) = 'xml:id')]" />
          <xsl:apply-templates mode="ctxsl:maybensnuke" />
        </xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
