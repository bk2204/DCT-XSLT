<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:param name="body.start.indent" select="'0pt'" />
  <xsl:param name="header.rule" select="0" />
  <xsl:param name="footer.rule" select="0" />
  <xsl:param name="appendix.autolabel" select="0" />
  <xsl:param name="chapter.autolabel" select="0" />
  <xsl:param name="part.autolabel" select="0" />
  <xsl:param name="generate.consistent.ids" select="1" />
  <xsl:param name="copy.comments" select="0" />
  <xsl:template match="comment()">
    <xsl:if test="$copy.comments">
      <xsl:copy-of select="."/>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
