<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:cc="http://web.resource.org/cc/"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:str="http://exslt.org/strings">
  <xsl:output method="text" encoding="UTF-8" indent="no" />

  <xsl:template match="@*|node()">
    <xsl:copy><xsl:apply-templates select="@*|node()"/></xsl:copy>
  </xsl:template>

  <xsl:template match="db:title">
    <xsl:apply-templates select=".//text()"/><xsl:text>&#x0a;</xsl:text>
    <xsl:value-of select="str:padding(string-length(.//text()), '=')"/>
    <xsl:text>&#x0a;</xsl:text>
  </xsl:template>

  <xsl:template match="db:emphasis">
    <xsl:text>_</xsl:text><xsl:apply-templates /><xsl:text>_</xsl:text>
  </xsl:template>

  <xsl:template match="db:strong">
    <xsl:text>*</xsl:text><xsl:apply-templates /><xsl:text>*</xsl:text>
  </xsl:template>

  <xsl:template match="db:literallayout">
    <xsl:text>[verse,subs=normal]&#x0a;_____&#x0a;</xsl:text><xsl:apply-templates
      /><xsl:text>&#x0a;_____&#x0a;</xsl:text>
  </xsl:template>

  <xsl:template match="db:quote">
    <xsl:text>``</xsl:text><xsl:apply-templates /><xsl:text>''</xsl:text>
  </xsl:template>

  <xsl:template match="db:personname|db:orgname">
    <xsl:value-of select=".//text()"/>
  </xsl:template>

  <xsl:template match="db:author">
    <xsl:text>:Author:&#x09;</xsl:text><xsl:apply-templates select="db:personname|db:orgname"/><xsl:text>&#x0a;</xsl:text>
  </xsl:template>

  <xsl:template match="db:info">
    <xsl:apply-templates select="db:title"/>
    <xsl:apply-templates select="db:author"/>
  </xsl:template>

  <xsl:template match="db:article">
    <xsl:apply-templates select="db:title"/>
    <xsl:apply-templates select="db:info"/>
    <xsl:text>&#x0a;</xsl:text>
    <xsl:apply-templates select="db:*[not(local-name() = 'title') and
      not(local-name() = 'info')]"/>
  </xsl:template>
</xsl:stylesheet>
