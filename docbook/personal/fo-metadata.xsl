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
	Items that are imported first have the lowest priority, followed by
	later imports, followed by this sheet.
	-->
	<!--<xsl:output method="xml" indent="no"/>-->
	<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/fo/docbook.xsl" />
	<xsl:import href="metadata.xsl" />

	<!--
	These stylesheets were derived in part from the DocBook XSL stylesheets,
	version 1.73.2.dfsg.1-5 (as distributed by Debian).  They were subsequently
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
	<xsl:template name="ctxsl:fo-declarations">
		<xsl:param name="element"/>
		<fo:declarations>
			<xsl:call-template name="ctxsl:fo-metadata">
				<xsl:with-param name="element" select="$element"/>
			</xsl:call-template>
		</fo:declarations>
	</xsl:template>

	<xsl:template name="ctxsl:fo-metadata">
		<xsl:param name="element"/>
		<xsl:call-template name="ctxsl:metadata">
			<xsl:with-param name="element" select="$element"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="*" mode="process.root">
		<xsl:variable name="document.element" select="self::*"/>

		<xsl:call-template name="root.messages"/>

		<xsl:variable name="title">
			<xsl:choose>
				<xsl:when test="$document.element/title[1]">
					<xsl:value-of select="$document.element/title[1]"/>
				</xsl:when>
				<xsl:otherwise>[could not find document title]</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<!-- Include all id values in XEP output -->
		<xsl:if test="$xep.extensions != 0">
			<xsl:processing-instruction 
				name="xep-pdf-drop-unused-destinations">false</xsl:processing-instruction>
		</xsl:if>

		<fo:root xsl:use-attribute-sets="root.properties">
			<xsl:attribute name="language">
				<xsl:call-template name="l10n.language">
					<xsl:with-param name="target" select="/*[1]"/>
				</xsl:call-template>
			</xsl:attribute>

			<xsl:if test="$xep.extensions != 0">
				<xsl:call-template name="xep-pis"/>
				<xsl:call-template name="xep-document-information"/>
			</xsl:if>
			<xsl:if test="$axf.extensions != 0">
				<xsl:call-template name="axf-document-information"/>
			</xsl:if>

			<xsl:call-template name="setup.pagemasters"/>

			<xsl:call-template name="ctxsl:fo-declarations">
				<xsl:with-param name="element" select="$document.element"/>
			</xsl:call-template>

			<xsl:if test="$fop.extensions != 0">
				<xsl:apply-templates select="$document.element" mode="fop.outline"/>
			</xsl:if>

			<xsl:if test="$fop1.extensions != 0">
				<xsl:variable name="bookmarks">
					<xsl:apply-templates select="$document.element" 
						mode="fop1.outline"/>
				</xsl:variable>
				<xsl:if test="string($bookmarks) != ''">
					<fo:bookmark-tree>
						<xsl:copy-of select="$bookmarks"/>
					</fo:bookmark-tree>
				</xsl:if>
			</xsl:if>

			<xsl:if test="$xep.extensions != 0">
				<xsl:variable name="bookmarks">
					<xsl:apply-templates select="$document.element" mode="xep.outline"/>
				</xsl:variable>
				<xsl:if test="string($bookmarks) != ''">
					<rx:outline xmlns:rx="http://www.renderx.com/XSL/Extensions">
						<xsl:copy-of select="$bookmarks"/>
					</rx:outline>
				</xsl:if>
			</xsl:if>

			<xsl:if test="$arbortext.extensions != 0 and $ati.xsl11.bookmarks != 0">
				<xsl:variable name="bookmarks">
					<xsl:apply-templates select="$document.element"
						mode="ati.xsl11.bookmarks"/>
				</xsl:variable>
				<xsl:if test="string($bookmarks) != ''">
					<fo:bookmark-tree>
						<xsl:copy-of select="$bookmarks"/>
					</fo:bookmark-tree>
				</xsl:if>
			</xsl:if>

			<xsl:apply-templates select="$document.element"/>
		</fo:root>
	</xsl:template>

	<!-- Silence the normal Debian messages. -->
	<xsl:template name="root.messages" />
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
