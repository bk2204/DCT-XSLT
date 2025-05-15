<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!--
  These stylesheets were derived in part from the DocBook XSL-NS stylesheets,
  version 1.76.0~RC1+dfsg-1 (as distributed by Debian).  They were subsequently
  modified.  Therefore, the following copyright and license apply to those
  portions:

  Copyright © 1999-2006 Norman Walsh.
  Copyright © 2003 Jiří Kosek.
  Copyright © 2004,2005 Steve Ball.
  Copyright © 2005 The DocBook Project.

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to
  deal in the Software without restriction, including without limitation the
  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
  sell copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  Except as contained in this notice, the names of individuals credited with
  contribution to this software shall not be used in advertising or otherwise
  to promote the sale, use or other dealings in this Software without prior
  written authorization from the individuals in question.

  Any stylesheet derived from this Software that is publically distributed
  will be identified with a different name and the version strings in any
  derived Software will be changed so that no possibility of confusion between
  the derived package and this Software will exist.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  NORMAN WALSH OR ANY OTHER CONTRIBUTOR BE LIABLE FOR ANY CLAIM, DAMAGES OR
  OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  The remainder of the stylesheet and any copyrightable modifications to the
  above are licensed as follows:

  Copyright © 2011 brian m. carlson

  Permission is hereby granted, free of charge, to any person obtaining a
  copy of this software and associated documentation files (the "Software"),
  to deal in the Software without restriction, including without limitation
  the rights to use, copy, modify, merge, publish, distribute, sublicense,
  and/or sell copies of the Software, and to permit persons to whom the
  Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included
  in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
  IN THE SOFTWARE.
  -->

  <!--
    No released version of fop supports catalog resolving, so resolve to a
    local location until this is fixed.
    -->
  <xsl:param name="draft.watermark.image">file:///usr/share/xml/docbook/stylesheet/docbook-xsl-ns/images/draft.png</xsl:param>

  <!-- Avoid a needless change of font in printed format. -->
  <xsl:template match="db:systemitem">
    <xsl:call-template name="inline.charseq"/>
  </xsl:template>

  <xsl:template match="db:epigraph">
    <fo:block font-size="0.9em" start-indent="1em">
      <xsl:apply-imports/>
    </fo:block>
  </xsl:template>

  <!-- Below are derivatives of the DocBook XSL-NS Stylesheets. -->
  <xsl:template name="page.number.format">
    <xsl:param name="element" select="local-name(.)"/>
    <xsl:param name="master-reference" select="''"/>

    <xsl:choose>
      <xsl:when test="$element = 'toc' and self::db:book">i</xsl:when>
      <xsl:when test="$element = 'preface'">i</xsl:when>
      <xsl:when test="$element = 'dedication'">i</xsl:when>
      <xsl:when test="$element = 'acknowledgements'">i</xsl:when>
      <xsl:when test="self::db:book">i</xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
