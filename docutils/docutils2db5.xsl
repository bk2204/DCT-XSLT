<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
  exclude-result-prefixes="db xsl"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

  <!-- Ignored elements -->
  <xsl:template match="decoration"/>
  <xsl:template match="topic"/>
  <xsl:template match="sidebar"/>
  <xsl:template match="transition"/>

  <!-- Root element -->
  <xsl:template match="document">
    <db:article xmlns="http://docbook.org/ns/docbook" version="5.0">
      <xsl:apply-templates/>
    </db:article>
  </xsl:template>

  <!-- Title elements -->
  <xsl:template match="title">
    <db:title><xsl:apply-templates/></db:title>
  </xsl:template>

  <xsl:template match="subtitle">
    <db:subtitle><xsl:apply-templates/></db:subtitle>
  </xsl:template>

  <!-- Bibliographic elements -->
  <xsl:template name="authorship">
    <db:author>
      <db:personname><xsl:apply-templates/></db:personname>
      <xsl:apply-templates
        select="following-sibling::organization[id(preceding-sibling::author[1])=id(.)]"/>
      <xsl:apply-templates
        select="following-sibling::address[id(preceding-sibling::author[1])=id(.)]"/>
      <xsl:apply-templates
        select="following-sibling::contact[id(preceding-sibling::author[1])=id(.)]"/>
    </db:author>
  </xsl:template>

  <xsl:template match="docinfo|info">
    <db:info>
      <!-- status must go first because it creates an attribute. -->
      <xsl:apply-templates select="status"/>
      <!-- Handle authorship. -->
      <xsl:apply-templates select="authors"/>
      <xsl:apply-templates select="author"/>
      <!-- Everything else not author-related. -->
      <xsl:apply-templates select="version|revision|date|copyright|field"/>
    </db:info>
  </xsl:template>

  <!-- This requires that tags describing the author follow this tag. -->
  <xsl:template match="author">
    <xsl:call-template name="authorship"/>
  </xsl:template>

  <xsl:template match="authors">
    <db:authorgroup>
      <xsl:for-each select="author">
        <xsl:call-template name="authorship"/>
      </xsl:for-each>
    </db:authorgroup>
  </xsl:template>

  <!-- This uses shortaffil because it is the most general. -->
  <xsl:template match="organization">
    <db:affiliation>
      <db:shortaffil><xsl:apply-templates/></db:shortaffil>
    </db:affiliation>
  </xsl:template>

  <xsl:template match="address">
    <db:address><xsl:apply-templates/></db:address>
  </xsl:template>

  <!-- This is usually an email address. -->
  <xsl:template match="contact">
    <db:email><xsl:apply-templates/></db:email>
  </xsl:template>

  <xsl:template match="version|revision">
    <db:edition><xsl:apply-templates/></db:edition>
  </xsl:template>

  <xsl:template match="status">
    <xsl:attribute name="status">
      <xsl:value-of select="text()"/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match="date">
    <db:date><xsl:apply-templates/></db:date>
  </xsl:template>

  <xsl:template match="copyright">
    <db:legalnotice>
      <db:para>
        <xsl:apply-templates/>
      </db:para>
    </db:legalnotice>
  </xsl:template>

  <!-- Structural elements -->
  <xsl:template match="section">
    <db:section>
      <xsl:apply-templates/>
    </db:section>
  </xsl:template>

  <!-- Body elements -->
  <xsl:template match="paragraph">
    <db:para>
      <xsl:apply-templates/>
    </db:para>
  </xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 et: -->
