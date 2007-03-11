<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns="http://www.w3.org/1999/xhtml"
	version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
	These stylesheets were derived in part from the DocBook XSL stylesheets,
	version 1.71.0.dfsg.1-2 (as distributed by Debian).  They were subsequently
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

	Copyright © 2007 Brian M. Carlson
	
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
<xsl:template match="tocpart|tocchap|tocdiv                      |toclevel1|toclevel2|toclevel3|toclevel4|toclevel5">
  <xsl:variable name="sub-toc">
    <xsl:if test="tocchap|tocdiv|toclevel1|toclevel2|toclevel3|toclevel4|toclevel5">
      <xsl:choose>
        <xsl:when test="$toc.list.type = 'dl'">
          <dd>
            <xsl:element name="{$toc.list.type}" namespace="http://www.w3.org/1999/xhtml">
              <xsl:apply-templates select="tocchap|tocdiv|toclevel1|toclevel2|toclevel3|toclevel4|toclevel5"/>
            </xsl:element>
          </dd>
        </xsl:when>
        <xsl:otherwise>
          <xsl:element name="{$toc.list.type}" namespace="http://www.w3.org/1999/xhtml">
            <xsl:apply-templates select="tocchap|tocdiv|toclevel1|toclevel2|toclevel3|toclevel4|toclevel5"/>
          </xsl:element>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:variable>

  <xsl:apply-templates select="tocentry[position() != last()]"/>

  <xsl:choose>
    <xsl:when test="$toc.list.type = 'dl'">
      <dt>
        <xsl:apply-templates select="tocentry[position() = last()]"/>
      </dt>
      <xsl:copy-of select="$sub-toc"/>
    </xsl:when>
    <xsl:otherwise>
      <li>
        <xsl:apply-templates select="tocentry[position() = last()]"/>
        <xsl:copy-of select="$sub-toc"/>
      </li>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
