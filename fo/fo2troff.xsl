<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- text-align (inherit, start, etc.)
       {linefeed,white-space}-treatment
  -->
  <xsl:output method="text" indent="no" encoding="UTF-8"/>
  <xsl:template name="break">
    <xsl:text>.br&#xa;</xsl:text>
  </xsl:template>
  <xsl:template name="newline">
    <xsl:text>&#x000a;</xsl:text>
  </xsl:template>
  <xsl:template name="insert-zwnj">
    <xsl:text>\&amp;</xsl:text>
  </xsl:template>
  <xsl:template name="page-setup">
    <xsl:text>.pl 11i
.po 0.5i
.ll 7.5i
.de HD
.sp 0.5i
..
.de FO
.bp
..
.wh 0 HD
.wh -0.5i FO
</xsl:text>
  </xsl:template>
  <xsl:template name="emit-attributes-begin">
    <xsl:apply-templates select="ancestor-or-self::*/@font-family[1]"/>
    <xsl:apply-templates select="ancestor-or-self::*/@hyphenate[1]"/>
    <xsl:call-template name="font-face"/>
    <xsl:call-template name="align-and-fill">
      <xsl:with-param name="align"
        select="ancestor-or-self::*/@text-align[string(.) != 'inherit'][1]"/>
      <xsl:with-param name="wrap"
        select="ancestor-or-self::*/@wrap-option[string(.) != 'inherit'][1]"/>
      <xsl:with-param name="linefeed"
        select="ancestor-or-self::*/@linefeed-treatment[string(.) != 'inherit'][1]"/>
      <xsl:with-param name="whitespace"
        select="ancestor-or-self::*/@white-space-treatment[string(.) != 'inherit'][1]"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="emit-attributes-end">
    <xsl:apply-templates select="ancestor::*/@font-family[1]"/>
    <xsl:apply-templates select="ancestor::*/@hyphenate[1]"/>
    <xsl:call-template name="font-face">
      <xsl:with-param name="weight" select="ancestor::*/@font-weight[1]"/>
      <xsl:with-param name="style" select="ancestor::*/@font-style[1]"/>
    </xsl:call-template>
    <xsl:call-template name="align-and-fill">
      <xsl:with-param name="align"
        select="ancestor::*/@text-align[string(.) != 'inherit'][1]"/>
      <xsl:with-param name="wrap"
        select="ancestor::*/@wrap-option[string(.) != 'inherit'][1]"/>
      <xsl:with-param name="linefeed"
        select="ancestor::*/@linefeed-treatment[string(.) != 'inherit'][1]"/>
      <xsl:with-param name="whitespace"
        select="ancestor::*/@white-space-treatment[string(.) != 'inherit'][1]"/>
    </xsl:call-template>
  </xsl:template>
  <xsl:template name="handle-group">
    <xsl:param name="break" select="0"/>

    <xsl:call-template name="emit-attributes-begin"/>
    <xsl:if test="$break">
      <xsl:call-template name="break"/>
    </xsl:if>
    <xsl:apply-templates select="node()"/>
    <xsl:if test="$break">
      <xsl:call-template name="break"/>
    </xsl:if>
    <xsl:call-template name="emit-attributes-end"/>
  </xsl:template>
  <xsl:template name="block-attributes-end">
    <xsl:apply-templates select="@break-after"/>
  </xsl:template>

  <xsl:template name="font-face">
    <xsl:param name="weight" select="ancestor-or-self::*/@font-weight[1]"/>
    <xsl:param name="style" select="ancestor-or-self::*/@font-style[1]"/>
    <xsl:choose>
      <xsl:when test="$weight = 'bold' and $style = 'italic'">
        <xsl:text>'ft BI&#x0a;</xsl:text>
      </xsl:when>
      <xsl:when test="$weight = 'bold'">
        <xsl:text>'ft B&#x0a;</xsl:text>
      </xsl:when>
      <xsl:when test="$style = 'italic'">
        <xsl:text>'ft I&#x0a;</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>'ft R&#x0a;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="align-and-fill">
    <xsl:param name="align"/>
    <xsl:param name="wrap"/>
    <xsl:param name="linefeed"/>
    <xsl:param name="whitespace"/>

    <xsl:variable name="adjust">
      <xsl:choose>
        <xsl:when test="$align = 'center'">
          <xsl:text>center</xsl:text>
        </xsl:when>
        <xsl:when test="$align = 'justify'">
          <xsl:text>justify</xsl:text>
        </xsl:when>
        <xsl:when test="$align = 'start' or $align = 'left'">
          <xsl:text>left</xsl:text>
        </xsl:when>
        <xsl:when test="$align = 'end' or $align = 'right'">
          <xsl:text>right</xsl:text>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="fill">
      <xsl:choose>
        <xsl:when test="$wrap = 'no-wrap' and $linefeed = 'preserve'">
          <xsl:text>false</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>true</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$fill = 'false' and $align = 'center'">
        <xsl:text>'nf&#x0a;</xsl:text>
        <xsl:text>'ce 9999&#x0a;</xsl:text>
      </xsl:when>
      <xsl:when test="$fill = 'false'">
        <xsl:text>'ce 0&#x0a;</xsl:text>
        <xsl:text>'nf&#x0a;</xsl:text>
      </xsl:when>
      <xsl:when test="$align = 'center'">
        <xsl:text>'ce 0&#x0a;</xsl:text>
        <xsl:text>'fi&#x0a;</xsl:text>
        <xsl:text>'ad c&#x0a;</xsl:text>
      </xsl:when>
      <xsl:when test="$align = 'justify'">
        <xsl:text>'ce 0&#x0a;</xsl:text>
        <xsl:text>'fi&#x0a;</xsl:text>
        <xsl:text>'ad b&#x0a;</xsl:text>
      </xsl:when>
      <xsl:when test="$align = 'left'">
        <xsl:text>'ce 0&#x0a;</xsl:text>
        <xsl:text>'fi&#x0a;</xsl:text>
        <xsl:text>'ad l&#x0a;</xsl:text>
      </xsl:when>
      <xsl:when test="$align = 'right'">
        <xsl:text>'ce 0&#x0a;</xsl:text>
        <xsl:text>'fi&#x0a;</xsl:text>
        <xsl:text>'ad r&#x0a;</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="fo:root">
    <!-- Punt on layouts for now. -->
    <xsl:call-template name="page-setup"/>
    <xsl:apply-templates select="fo:page-sequence"/>
  </xsl:template>
  <xsl:template match="fo:page-sequence">
    <xsl:apply-templates select="fo:flow"/>
  </xsl:template>
  <xsl:template match="fo:flow">
    <xsl:apply-templates select="fo:block"/>
  </xsl:template>
  <xsl:template match="fo:block">
    <!--<xsl:call-template name="break"/>-->
    <xsl:call-template name="handle-group">
      <xsl:with-param name="break" select="1"/>
    </xsl:call-template>
    <xsl:call-template name="block-attributes-end"/>
    <xsl:apply-templates select="@break-after"/>
  </xsl:template>
  <xsl:template match="fo:inline">
    <xsl:call-template name="handle-group"/>
  </xsl:template>
  <xsl:template match="text()">
    <xsl:if test="starts-with(normalize-space(.),'.')">
      <xsl:call-template name="insert-zwnj"/>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="string(ancestor::*/@white-space-collapse[1])='false'">
        <xsl:value-of select="."/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="normalize-space(.)"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="local-name(..)!='ablock' and string-length(normalize-space(.))!=0">
      <xsl:call-template name="newline"/>
    </xsl:if>
  </xsl:template>
  <xsl:template match="@font-family">
    <xsl:text>'fam </xsl:text><xsl:value-of select="substring(.,1,1)"/>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>
  <xsl:template match="@hyphenate">
    <xsl:choose>
      <xsl:when test="string(.)!='true'">
        <xsl:text>'hy 0&#xa;</xsl:text>
      </xsl:when>
      <xsl:when test="string(.)='true'">
        <xsl:text>'hy 1&#xa;</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="@break-after">
    <xsl:choose>
      <xsl:when test="string(.)!='page'">
        <xsl:text>.bp&#xa;</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <xsl:template match="@font-weight|@font-style">
    <xsl:call-template name="font-face"/>
  </xsl:template>
  <xsl:template match="@*"/>
  <!--
    <xsl:message>Ignoring attribute <xsl:value-of select="local-name(.)"/>.</xsl:message>
  </xsl:template>-->
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 et: -->
