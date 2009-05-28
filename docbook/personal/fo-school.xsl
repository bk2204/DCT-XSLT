<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
	These stylesheets were derived in part from the DocBook XSL stylesheets,
	version 1.74.3+dfsg-1 (as distributed by Debian).  They were subsequently
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

	Copyright © 2007, 2009 Brian M. Carlson
	
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
	<xsl:import href="fo.xsl" />
	<xsl:param name="header.rule" select="0" />
	<xsl:param name="footer.rule" select="0" />
	<xsl:param name="line-height" select="2.0" />
	<xsl:param name="body.start.indent">0pt</xsl:param>
	<xsl:param name="body.font.master">12</xsl:param>
	<!-- Use standard PostScript fonts, just in case. -->
	<xsl:param name="body.font.family" select="'Times'" />
	<xsl:param name="title.font.family" select="'Times'" />
	<xsl:param name="dingbat.font.family" select="'Times'" />
	<!-- Indent the first line of each paragraph. -->
	<xsl:attribute-set name="normal.para.spacing">
		<xsl:attribute name="text-indent">2.5em</xsl:attribute>
		<xsl:attribute name="space-before.optimum">1em</xsl:attribute>
		<xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
	</xsl:attribute-set>

	<xsl:template match="bibliography">
		<xsl:variable name="id">
			<xsl:call-template name="object.id"/>
		</xsl:variable>
	
		<xsl:choose>
			<xsl:when test="not(parent::*) or parent::part or parent::book">
				<xsl:variable name="master-reference">
					<xsl:call-template name="select.pagemaster"/>
				</xsl:variable>
	
				<fo:page-sequence hyphenate="{$hyphenate}"
													master-reference="{$master-reference}">
					<xsl:attribute name="language">
						<xsl:call-template name="l10n.language"/>
					</xsl:attribute>
					<xsl:attribute name="format">
						<xsl:call-template name="page.number.format">
							<xsl:with-param name="master-reference" select="$master-reference"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:attribute name="initial-page-number">
						<xsl:call-template name="initial.page.number">
							<xsl:with-param name="master-reference" select="$master-reference"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:attribute name="force-page-count">
						<xsl:call-template name="force.page.count">
							<xsl:with-param name="master-reference" select="$master-reference"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:attribute name="hyphenation-character">
						<xsl:call-template name="gentext">
							<xsl:with-param name="key" select="'hyphenation-character'"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:attribute name="hyphenation-push-character-count">
						<xsl:call-template name="gentext">
							<xsl:with-param name="key" select="'hyphenation-push-character-count'"/>
						</xsl:call-template>
					</xsl:attribute>
					<xsl:attribute name="hyphenation-remain-character-count">
						<xsl:call-template name="gentext">
							<xsl:with-param name="key" select="'hyphenation-remain-character-count'"/>
						</xsl:call-template>
					</xsl:attribute>
	
					<xsl:apply-templates select="." mode="running.head.mode">
						<xsl:with-param name="master-reference" select="$master-reference"/>
					</xsl:apply-templates>
					<xsl:apply-templates select="." mode="running.foot.mode">
						<xsl:with-param name="master-reference" select="$master-reference"/>
					</xsl:apply-templates>
	
					<fo:flow flow-name="xsl-region-body">
						<xsl:call-template name="set.flow.properties">
							<xsl:with-param name="element" select="local-name(.)"/>
							<xsl:with-param name="master-reference" select="$master-reference"/>
						</xsl:call-template>
	
						<fo:block id="{$id}">
							<xsl:call-template name="bibliography.titlepage"/>
						</fo:block>
						<xsl:apply-templates/>
					</fo:flow>
				</fo:page-sequence>
			</xsl:when>
			<xsl:otherwise>
				<fo:block id="{$id}"
									break-before="page"
									space-before.minimum="1em"
									space-before.optimum="1.5em"
									space-before.maximum="2em">
					<xsl:call-template name="bibliography.titlepage"/>
				</fo:block>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="article/appendix">
	  <xsl:variable name="id">
	    <xsl:call-template name="object.id"/>
	  </xsl:variable>
	
	  <xsl:variable name="title">
	    <xsl:apply-templates select="." mode="object.title.markup"/>
	  </xsl:variable>
	
	  <xsl:variable name="titleabbrev">
	    <xsl:apply-templates select="." mode="titleabbrev.markup"/>
	  </xsl:variable>
	
	  <fo:block break-before="page" id='{$id}'>
	    <xsl:if test="$axf.extensions != 0">
	      <xsl:attribute name="axf:outline-level">
	        <xsl:value-of select="count(ancestor::*)+2"/>
	      </xsl:attribute>
	      <xsl:attribute name="axf:outline-expand">false</xsl:attribute>
	      <xsl:attribute name="axf:outline-title">
	        <xsl:value-of select="normalize-space($titleabbrev)"/>
	      </xsl:attribute>
	    </xsl:if>
	
	    <xsl:if test="$passivetex.extensions != 0">
	      <fotex:bookmark xmlns:fotex="http://www.tug.org/fotex" 
	                      fotex-bookmark-level="{count(ancestor::*)+2}" 
	                      fotex-bookmark-label="{$id}">
	        <xsl:value-of select="$titleabbrev"/>
	      </fotex:bookmark>
	    </xsl:if>
	
			<fo:block xsl:use-attribute-sets="article.appendix.title.properties">
	      <fo:marker marker-class-name="section.head.marker">
	        <xsl:choose>
	          <xsl:when test="$titleabbrev = ''">
	            <xsl:value-of select="$title"/>
	          </xsl:when>
	          <xsl:otherwise>
	            <xsl:value-of select="$titleabbrev"/>
	          </xsl:otherwise>
	        </xsl:choose>
	      </fo:marker>
	      <xsl:copy-of select="$title"/>
	    </fo:block>
	
	    <xsl:variable name="toc.params">
	        <xsl:call-template name="find.path.params">
	          <xsl:with-param name="table" select="normalize-space($generate.toc)"/>
	        </xsl:call-template>
	      </xsl:variable>
	
	      <xsl:if test="contains($toc.params, 'toc')">
	        <xsl:call-template name="component.toc">
	          <xsl:with-param name="toc.title.p" 
	                          select="contains($toc.params, 'title')"/>
	        </xsl:call-template>
	        <xsl:call-template name="component.toc.separator"/>
	      </xsl:if>
	
	    <xsl:apply-templates/>
	  </fo:block>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
