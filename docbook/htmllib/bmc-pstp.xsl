<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
  version="1.0"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xi="http://www.w3.org/2003/XInclude"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:cc="http://creativecommons.org/ns#"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="db xlink ctxsl xsl xi xhtml dc cc rdf">
  <xsl:import href="pstp.xsl"/>
  <xsl:import href="restructure.xsl"/>

  <xsl:template match="xhtml:div/@style" mode="ctxsl:all-xhtml2xhtml"/>
  <xsl:template match="@xml:space" mode="ctxsl:all-xhtml2xhtml"/>
  <xsl:template match="xhtml:hr" mode="ctxsl:all-xhtml2xhtml"/>
  <xsl:template match="db:extendedlink" mode="ctxsl:all-xhtml2xhtml"/>
  <xsl:template match="rdf:RDF" mode="ctxsl:all-xhtml2xhtml"/>
  <xsl:template match="xhtml:div[@class = 'footnotes']/xhtml:hr" mode="ctxsl:all-xhtml2xhtml"/>
  <xsl:template match="xhtml:div[@class = 'footnotes']/xhtml:br" mode="ctxsl:all-xhtml2xhtml"/>
  <xsl:template match="xhtml:acronym" mode="ctxsl:all-xhtml2xhtml">
    <xsl:apply-templates mode="ctxsl:all-xhtml2xhtml"/>
  </xsl:template>
  <xsl:template name="ctxsl:footer" />
  <xsl:template match="xhtml:div[@class and ./xhtml:div[@class = 'titlepage']//xhtml:a[@id = 'sidebar']]" mode="ctxsl:move-sidebar">
    <xsl:copy>
      <xsl:if test="xhtml:div[@class='titlepage']//xhtml:*[@class='title']/xhtml:a[@id]">
        <xsl:attribute name="{$ctxsl:id-name}" namespace="{$ctxsl:id-ns}">
          <xsl:value-of select="xhtml:div[@class='titlepage']//xhtml:*[@class='title']/xhtml:a/@id" />
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="@*" mode="ctxsl:all-xhtml2xhtml"/>
      <xsl:apply-templates select="xhtml:div[@class = 'titlepage']" mode="ctxsl:all-xhtml2xhtml"/>
      <xsl:apply-templates select="xhtml:div[@class = 'toc']" mode="ctxsl:all-xhtml2xhtml"/>
      <div class="flow">
        <xsl:apply-templates select="xhtml:*[not((@class = 'titlepage') or (@class = 'toc'))]" mode="ctxsl:all-xhtml2xhtml"/>
      </div>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="xhtml:div[@class and ./xhtml:div[@class = 'titlepage']//xhtml:a[@id = 'sidebar']]" mode="ctxsl:all-xhtml2xhtml"/>
  <xsl:template match="xhtml:body" mode="ctxsl:all-xhtml2xhtml">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <div class="content">
        <xsl:apply-templates select="node()" mode="ctxsl:all-xhtml2xhtml"/>
      </div>
      <xsl:apply-templates select="//xhtml:div[@class and ./xhtml:div[@class = 'titlepage']//xhtml:a[@id = 'sidebar']]"
        mode="ctxsl:move-sidebar"/>
      <xsl:call-template name="ctxsl:footer-cb"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
