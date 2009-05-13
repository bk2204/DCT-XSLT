<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:sverb="http://nwalsh.com/xslt/ext/com.nwalsh.saxon.Verbatim"
  xmlns:xverb="com.nwalsh.xalan.Verbatim"
  xmlns:lxslt="http://xml.apache.org/xslt"
  xmlns:exsl="http://exslt.org/common"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	exclude-result-prefixes="sverb xverb lxslt exsl ctxsl">
	<!--
	These stylesheets were derived in part from the DocBook XSL stylesheets,
	version 1.75.0+dfsg-4 (as distributed by Debian).  They were subsequently
	modified.  Therefore, the following copyright and license apply to those
	portions:

	Copyright © 1999-2007 Norman Walsh.
	Copyright © 2003 Jiří Kosek.
	Copyright © 2004-2007 Steve Ball.
	Copyright © 2005-2007 The DocBook Project.
	
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

	Copyright © 2009 brian m. carlson
	
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
	<xsl:param name="ctxsl:tab-indent" select="'2em'" />

	<xsl:template name="ctxsl:indent-tab-lines">
		<xsl:param name="content" select="''" />
		<xsl:param name="count" select="1" />

		<xsl:choose>
			<xsl:when test="contains($content, '&#x9;')">
				<xsl:variable name="line" select="substring-before($content, '&#x9;')"/>
				<xsl:variable name="rest" select="substring-after($content, '&#x9;')"/>

				<xsl:copy-of select="$line" />
				<fo:inline>
					<xsl:attribute name="padding-start">
						<xsl:value-of select="$ctxsl:tab-indent" />
					</xsl:attribute>
					<xsl:call-template name="ctxsl:indent-tab-lines">
						<xsl:with-param name="content" select="$rest" />
						<xsl:with-param name="count" select="$count + 1" />
					</xsl:call-template>
				</fo:inline>
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$content" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="ctxsl:indent-lines">
		<xsl:param name="content" select="''" />
		<xsl:param name="count" select="1" />

		<xsl:choose>
			<xsl:when test="contains($content, '&#xA;')">
				<xsl:variable name="line" select="substring-before($content, '&#xA;')"/>
				<xsl:variable name="rest" select="substring-after($content, '&#xA;')"/>

				<xsl:call-template name="ctxsl:indent-tab-lines">
					<xsl:with-param name="content" select="$line" />
				</xsl:call-template>
				<xsl:text>&#xA;</xsl:text>
				<xsl:call-template name="ctxsl:indent-lines">
					<xsl:with-param name="content" select="$rest" />
					<xsl:with-param name="count" select="$count + 1" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="ctxsl:indent-tab-lines">
					<xsl:with-param name="content" select="$content" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="node()|@*" mode="ctxsl:indent">
		<xsl:copy>
			<xsl:copy-of select="@*" />
			<xsl:apply-templates mode="ctxsl:indent" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="fo:footnote" mode="ctxsl:indent">
		<xsl:copy>
			<xsl:copy-of select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="text()" mode="ctxsl:indent">
		<xsl:call-template name="ctxsl:indent-lines">
			<xsl:with-param name="content" select="." />
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="literallayout">
	  <xsl:param name="suppress-numbers" select="'0'"/>
	
	  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>
	
	  <xsl:variable name="content">
	    <xsl:choose>
	      <xsl:when test="$suppress-numbers = '0'
	                      and @linenumbering = 'numbered'
	                      and $use.extensions != '0'
	                      and $linenumbering.extension != '0'">
	        <xsl:call-template name="number.rtf.lines">
	          <xsl:with-param name="rtf">
	            <xsl:apply-templates/>
	          </xsl:with-param>
	        </xsl:call-template>
	      </xsl:when>
	      <xsl:otherwise>
	        <xsl:apply-templates/>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:variable>
	
	  <xsl:choose>
	    <xsl:when test="@class='monospaced'">
	      <xsl:choose>
	        <xsl:when test="$shade.verbatim != 0">
	          <fo:block id="{$id}"
	                    xsl:use-attribute-sets="monospace.verbatim.properties shade.verbatim.style">
	
	            <xsl:copy-of select="$content"/>
	          </fo:block>
	        </xsl:when>
	        <xsl:otherwise>
	          <fo:block id="{$id}"
	                    xsl:use-attribute-sets="monospace.verbatim.properties">
	            <xsl:copy-of select="$content"/>
	          </fo:block>
	        </xsl:otherwise>
	      </xsl:choose>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:choose>
	        <xsl:when test="$shade.verbatim != 0">
	          <fo:block id="{$id}"
							xsl:use-attribute-sets="verbatim.properties shade.verbatim.style">
							<xsl:apply-templates select="exsl:node-set($content)"
								mode="ctxsl:indent" />
	          </fo:block>
	        </xsl:when>
	        <xsl:otherwise>
	          <fo:block id="{$id}"
							xsl:use-attribute-sets="verbatim.properties">
							<xsl:apply-templates select="exsl:node-set($content)"
								mode="ctxsl:indent" />
	          </fo:block>
	        </xsl:otherwise>
	      </xsl:choose>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
