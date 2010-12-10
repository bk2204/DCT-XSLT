<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:fo="http://www.w3.org/1999/XSL/Format"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:date="http://exslt.org/dates-and-times"
	exclude-result-prefixes="db ctxsl xsl">
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

	Copyright © 2007, 2010 Brian M. Carlson
	
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
	<xsl:import href="../school/cvt.xsl" />
	<xsl:import href="../../lib/font-times.xsl" />
	<xsl:import href="../../lib/mla-coverpage.xsl" />
	<!-- Put the author in the right place. -->
	<xsl:template match="db:bookinfo/db:author|db:info/db:author" mode="titlepage.mode" priority="2">
		<fo:block xsl:use-attribute-sets="article.titlepage.recto.style">
			<xsl:call-template name="person.name"/>
		</fo:block>
	</xsl:template>
	<xsl:template match="db:author" mode="titlepage.mode">
		<fo:block xsl:use-attribute-sets="article.titlepage.recto.style">
			<xsl:call-template name="anchor"/>
			<xsl:call-template name="person.name"/>
			<xsl:if test="db:affiliation/db:orgname">
				<xsl:text>, </xsl:text>
				<xsl:apply-templates select="db:affiliation/db:orgname" mode="titlepage.mode"/>
			</xsl:if>
			<xsl:if test="db:email|db:affiliation/db:address/db:email">
				<xsl:text> </xsl:text>
				<xsl:apply-templates select="(db:email|db:affiliation/db:address/db:email)[1]"/>
			</xsl:if>
		</fo:block>
	</xsl:template>
	<xsl:template match="db:date" mode="titlepage.mode">
		<xsl:choose>
			<xsl:when test="date:month-name(.) != ''">
				<xsl:value-of
					select="concat(date:day-in-month(.), ' ', date:month-name(.), ' ', date:year(.))"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="db:confsponsor" mode="titlepage.mode">
		<xsl:if test="not(@role = 'instructor')">
			<xsl:message>Warning: legacy use of confsponsor on titlepage.</xsl:message>
		</xsl:if>
		<fo:block xsl:use-attribute-sets="article.titlepage.recto.style">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>
	<xsl:template match="db:conftitle" mode="titlepage.mode">
		<xsl:if test="not(@role = 'class')">
			<xsl:message>Warning: legacy use of conftitle on titlepage.</xsl:message>
		</xsl:if>
		<fo:block xsl:use-attribute-sets="article.titlepage.recto.style">
			<xsl:apply-templates/>
		</fo:block>
	</xsl:template>

	<xsl:template name="footer.content" />
	
	<!--
	From here on are derivative works of the DocBook stylesheets.
	-->

	<!-- Put the surname and page number in the header, on the right. -->
	<xsl:template name="header.content">
	  <xsl:param name="pageclass" select="''"/>
	  <xsl:param name="sequence" select="''"/>
	  <xsl:param name="position" select="''"/>
	  <xsl:param name="gentext-key" select="''"/>

  	<fo:block>

  	  <!-- sequence can be odd, even, first, blank -->
  	  <!-- position can be left, center, right -->
  	  <xsl:choose>
  	    <xsl:when test="$sequence = 'blank'">
  	      <!-- nothing -->
  	    </xsl:when>

				<xsl:when test="$position='left'">
					<!-- nop -->
  	    </xsl:when>

  	    <xsl:when test="($sequence='odd' or $sequence='even') and $position='center'">
  	      <xsl:if test="$pageclass != 'titlepage'">
  	        <xsl:choose>
  	          <xsl:when test="ancestor::db:book and ($double.sided != 0)">
  	            <fo:retrieve-marker retrieve-class-name="section.head.marker"
  	                                retrieve-position="first-including-carryover"
  	                                retrieve-boundary="page-sequence"/>
  	          </xsl:when>
							<xsl:otherwise>
								<!-- nop -->
  	          </xsl:otherwise>
  	        </xsl:choose>
  	      </xsl:if>
  	    </xsl:when>

  	    <xsl:when test="$position='center'">
  	      <!-- nothing for empty and blank sequences -->
  	    </xsl:when>

  	    <xsl:when test="$position='right'">
  	      <!-- Same for odd, even, empty, and blank sequences -->
  	      <xsl:if test="$sequence != 'first'">
						<xsl:value-of select="(/descendant::db:surname)[1]" /><xsl:text> </xsl:text><fo:page-number />
  	      </xsl:if>
  	    </xsl:when>

  	    <xsl:when test="$sequence = 'first'">
  	      <!-- nothing for first pages -->
  	    </xsl:when>

  	    <xsl:when test="$sequence = 'blank'">
  	      <!-- nothing for blank pages -->
  	    </xsl:when>
  	  </xsl:choose>
  	</fo:block>
	</xsl:template>
	<!-- Specify title properties. -->
	<xsl:attribute-set name="component.title.properties">
		<xsl:attribute name="text-align">center</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>
	<!-- Default attributes for titlepage info/* elements. -->
	<xsl:attribute-set name="article.titlepage.recto.style"
		use-attribute-sets="component.title.properties">
		<xsl:attribute name="text-align">left</xsl:attribute>
		<xsl:attribute name="font-weight">normal</xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="article.appendix.title.properties"
		use-attribute-sets="component.title.properties">
	</xsl:attribute-set>
	<!-- indent the first line of each paragraph. -->
	<xsl:attribute-set name="normal.para.spacing">
		<xsl:attribute name="text-indent">2.5em</xsl:attribute>
	</xsl:attribute-set>
</xsl:stylesheet>
