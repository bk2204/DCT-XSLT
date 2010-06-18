<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
	Copyright © 2007, 2009, 2010 brian m. carlson
	
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
	<xsl:import href="base.xsl" />
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

	<xsl:template match="db:bibliography">
		<xsl:choose>
			<xsl:when test="not(parent::*) or parent::db:part or parent::db:book">
				<xsl:apply-imports/>
			</xsl:when>
			<xsl:otherwise>
				<fo:block break-before="page">
					<xsl:apply-imports/>
				</fo:block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="db:article/db:appendix">
		<fo:block break-before="page">
			<xsl:apply-imports/>
		</fo:block>
	</xsl:template>
</xsl:stylesheet>
