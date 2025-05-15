<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:ng="http://docbook.org/docbook-ng"
  xmlns:db="http://docbook.org/ns/docbook"
  xmlns:x="adobe:ns:meta/"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
  exclude-result-prefixes="db ng exsl ctxsl">
  <!--
  These stylesheets were derived in part from the DocBook XSL-NS stylesheets,
  version 1.76.1+dfsg-1 (as distributed by Debian).  They were subsequently
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
  Items that are imported first have the lowest priority, followed by
  later imports, followed by this sheet.
  -->
  <xsl:import href="../../../project.xsl" />
  <xsl:import href="../../lib/metadata.xsl" />

  <!-- Metadata support ("Document Properties" in Adobe Reader) -->
  <xsl:template name="fop1-document-information">
    <xsl:variable name="authors" select="(//db:author|//db:editor|//db:corpauthor|//db:authorgroup)[1]"/>

    <xsl:variable name="title">
      <xsl:apply-templates select="/*[1]" mode="label.markup"/>
      <xsl:apply-templates select="/*[1]" mode="title.markup"/>
      <xsl:variable name="subtitle">
        <xsl:apply-templates select="/*[1]" mode="subtitle.markup"/>
      </xsl:variable>
      <xsl:if test="$subtitle !=''">
        <xsl:text> - </xsl:text>
        <xsl:value-of select="$subtitle"/>
      </xsl:if>
    </xsl:variable>

    <fo:declarations>
      <x:xmpmeta xmlns:x="adobe:ns:meta/">
        <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
          <xsl:copy-of select="/*[1]/db:info/rdf:RDF/rdf:Description"/>
          <rdf:Description rdf:about="" xmlns:dc="http://purl.org/dc/elements/1.1/">
            <!-- Dublin Core properties go here -->

            <!-- Title -->
            <dc:title><xsl:value-of select="normalize-space($title)"/></dc:title>

            <!-- Author -->
            <xsl:if test="$authors">
              <xsl:variable name="author">
                <xsl:choose>
                  <xsl:when test="$authors[self::db:authorgroup]">
                    <xsl:call-template name="person.name.list">
                      <xsl:with-param name="person.list"
                        select="$authors/*[self::db:author|self::db:corpauthor|
                        self::db:othercredit|self::db:editor]"/>
                    </xsl:call-template>
                  </xsl:when>
                  <xsl:when test="$authors[self::db:corpauthor]">
                    <xsl:value-of select="$authors"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:call-template name="person.name">
                      <xsl:with-param name="node" select="$authors"/>
                    </xsl:call-template>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:variable>

              <dc:creator><xsl:value-of select="normalize-space($author)"/></dc:creator>
            </xsl:if>

            <!-- Subject -->
            <xsl:if test="//db:subjectterm">
              <dc:description>
                <xsl:for-each select="//db:subjectterm">
                  <xsl:value-of select="normalize-space(.)"/>
                  <xsl:if test="position() != last()">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </xsl:for-each>
              </dc:description>
            </xsl:if>
          </rdf:Description>

          <rdf:Description rdf:about="" xmlns:pdf="http://ns.adobe.com/pdf/1.3/">
            <!-- PDF properties go here -->

            <!-- Keywords -->
            <xsl:if test="//db:keyword">
              <pdf:Keywords>
                <xsl:for-each select="//db:keyword">
                  <xsl:value-of select="normalize-space(.)"/>
                  <xsl:if test="position() != last()">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </xsl:for-each>
              </pdf:Keywords>
            </xsl:if>
          </rdf:Description>

          <rdf:Description rdf:about="" xmlns:xmp="http://ns.adobe.com/xap/1.0/">
            <!-- XMP properties go here -->

            <!-- Creator Tool -->
            <xmp:CreatorTool><xsl:value-of select="$ctxsl:project-name"/></xmp:CreatorTool>
          </rdf:Description>

        </rdf:RDF>
      </x:xmpmeta>
    </fo:declarations>
  </xsl:template>
</xsl:stylesheet>
