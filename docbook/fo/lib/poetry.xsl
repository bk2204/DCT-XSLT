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
	xmlns:db="http://docbook.org/ns/docbook"
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
	This is fairly subtle.  Normally, using padding-start with ctxsl:tab-indent
	works fine when we're using the FO to generate a PDF.  Unfortunately, FOP
	does a bad job of handling this when we're generating an RTF (which is needed
	for e.g. Glass Mountain); specifically, no indentation occurs.

	However, if we replace the padding-start with an appropriate number of em
	spaces or en spaces, this works well in both the PDF and RTF formats.
	Unfortunately, it's a bit less flexible, since we can only output a whole em
	or en worth of space.

	Here, we use en spaces and multiply the number of ems by two, so that we can
	deal with integral numbers of ens (and consequently, full and half ems.)
	Since ctxsl:repeat-content will only function if the total parameter is an
	integer, we'll fall back to using padding-start if we have an unusual size.
	-->
	<xsl:param name="ctxsl:tab-indent" select="'2em'" />
	<xsl:param name="ctxsl:tab-characters">
		<xsl:call-template name="ctxsl:repeat-content">
			<xsl:with-param name="content">&#x2002;</xsl:with-param>
			<xsl:with-param name="total"
				select="number(substring-before($ctxsl:tab-indent, 'em')) * 2" />
		</xsl:call-template>
	</xsl:param>
	<xsl:param name="ctxsl:tab-use-characters"
		select="(string-length($ctxsl:tab-characters) != 0)" />

	<xsl:template name="ctxsl:repeat-content">
		<xsl:param name="content" select="''"/>
		<xsl:param name="count" select="0"/>
		<xsl:param name="total" select="0"/>
		<xsl:if test="($count &lt; $total) and floor($total) = $total">
			<xsl:value-of select="$content"/>
			<xsl:call-template name="ctxsl:repeat-content">
				<xsl:with-param name="content" select="$content" />
				<xsl:with-param name="count" select="$count + 1" />
				<xsl:with-param name="total" select="$total" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="ctxsl:indent-tab-lines">
		<xsl:param name="content" select="''" />
		<xsl:param name="count" select="1" />

		<xsl:choose>
			<xsl:when test="contains($content, '&#x9;')">
				<xsl:variable name="line" select="substring-before($content, '&#x9;')"/>
				<xsl:variable name="rest" select="substring-after($content, '&#x9;')"/>

				<xsl:copy-of select="$line" />
				<fo:inline>
					<fo:inline>
						<xsl:choose>
							<xsl:when test="$ctxsl:tab-use-characters">
								<xsl:value-of select="$ctxsl:tab-characters" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="padding-start">
									<xsl:value-of select="$ctxsl:tab-indent" />
								</xsl:attribute>
								<xsl:text>&#x200b;</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</fo:inline>
					<xsl:choose>
						<xsl:when test="string-length($rest) = 0">
							<xsl:text>&#x200b;</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="ctxsl:indent-tab-lines">
								<xsl:with-param name="content" select="$rest" />
								<xsl:with-param name="count" select="$count + 1" />
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
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

	<xsl:template match="*|@*" mode="ctxsl:indent">
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

	<xsl:template match="db:literallayout">
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
