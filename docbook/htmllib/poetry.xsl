<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:sverb="http://nwalsh.com/xslt/ext/com.nwalsh.saxon.Verbatim"
  xmlns:xverb="com.nwalsh.xalan.Verbatim"
	xmlns:lxslt="http://xml.apache.org/xslt"
	xmlns:set="http://exslt.org/sets" 
  xmlns:exsl="http://exslt.org/common"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	exclude-result-prefixes="sverb xverb lxslt set exsl ctxsl">
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
	<xsl:param name="ctxsl:tab-indent-class" select="'indent'" />

	<xsl:template name="ctxsl:indent-tab-lines">
		<xsl:param name="content" select="''" />
		<xsl:param name="count" select="1" />

		<xsl:choose>
			<xsl:when test="contains($content, '&#x9;')">
				<xsl:variable name="line" select="substring-before($content, '&#x9;')"/>
				<xsl:variable name="rest" select="substring-after($content, '&#x9;')"/>

				<xsl:copy-of select="$line" />
				<span>
					<xsl:attribute name="class">
						<xsl:value-of select="$ctxsl:tab-indent-class" />
					</xsl:attribute>
					<xsl:call-template name="ctxsl:indent-tab-lines">
						<xsl:with-param name="content" select="$rest" />
						<xsl:with-param name="count" select="$count + 1" />
					</xsl:call-template>
				</span>
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
				<xsl:element name="br" namespace="http://www.w3.org/1999/xhtml"/>
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

	<xsl:template match="text()" mode="make.verbatim.mode">
	  <xsl:variable name="text" select="translate(., ' ', '&#160;')"/>

		<xsl:call-template name="ctxsl:indent-lines">
			<xsl:with-param name="content" select="$text" />
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
