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
	<xsl:template match="text()" mode="make.verbatim.mode">
	  <xsl:variable name="text" select="translate(., ' ', '&#160;')"/>
	
	  <xsl:choose>
	    <xsl:when test="not(contains($text, '&#10;') or contains($text, '&#9;'))">
	      <xsl:value-of select="$text"/>
	    </xsl:when>
	
	    <xsl:otherwise>
	      <xsl:variable name="len" select="string-length($text)"/>
	
	      <xsl:choose>
	        <xsl:when test="$len = 1">
	          <br/><xsl:text>
</xsl:text>
	        </xsl:when>
	
	        <xsl:otherwise>
	          <xsl:variable name="half" select="$len div 2"/>
	          <xsl:call-template name="make-verbatim-recursive">
	            <xsl:with-param name="text" select="substring($text, 1, $half)"/>
	          </xsl:call-template>
	          <xsl:call-template name="make-verbatim-recursive">
	            <xsl:with-param name="text" select="substring($text, ($half + 1), $len)"/>
	          </xsl:call-template>
	    	</xsl:otherwise>
	      </xsl:choose>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:template>

	<xsl:template name="ctxsl:make-verbatim-recursive">
  	<xsl:param name="text" select="''"/>

  	<xsl:choose>
			<xsl:when test="not(contains($text, '&#9;'))">
  	    <xsl:value-of select="$text"/>
			</xsl:when>

  	  <xsl:otherwise>
  	    <xsl:variable name="len" select="string-length($text)"/>

  	    <xsl:choose>
					<xsl:when test="$len = 1">
						<xsl:text>&#160;&#160;&#160;&#160;</xsl:text>
  	      </xsl:when>

  	      <xsl:otherwise>
  	  	  <xsl:variable name="half" select="$len div 2"/>
  	        <xsl:call-template name="ctxsl:make-verbatim-recursive">
  	  	    <xsl:with-param name="text" select="substring($text, 1, $half)"/>
  	  	  </xsl:call-template>
  	  	  <xsl:call-template name="ctxsl:make-verbatim-recursive">
  	  	    <xsl:with-param name="text" select="substring($text, ($half + 1), $len)"/>
  	  	  </xsl:call-template>
  	  	</xsl:otherwise>
  	    </xsl:choose>
  	  </xsl:otherwise>
  	</xsl:choose>
	</xsl:template>

	<xsl:template name="make-verbatim-recursive">
	  <xsl:param name="text" select="''"/>
	
	  <xsl:choose>
			<xsl:when test="not(contains($text, '&#10;'))">
				<xsl:call-template name="ctxsl:make-verbatim-recursive">
					<xsl:with-param name="text"><xsl:value-of select="$text"/></xsl:with-param>
				</xsl:call-template>
	    </xsl:when>
	
	    <xsl:otherwise>
	      <xsl:variable name="len" select="string-length($text)"/>
	
	      <xsl:choose>
	        <xsl:when test="$len = 1">
	          <br/><xsl:text>
</xsl:text>
	        </xsl:when>
	
	        <xsl:otherwise>
	    	  <xsl:variable name="half" select="$len div 2"/>
	          <xsl:call-template name="make-verbatim-recursive">
	    	    <xsl:with-param name="text" select="substring($text, 1, $half)"/>
	    	  </xsl:call-template>
	    	  <xsl:call-template name="make-verbatim-recursive">
	    	    <xsl:with-param name="text" select="substring($text, ($half + 1), $len)"/>
	    	  </xsl:call-template>
	    	</xsl:otherwise>
	      </xsl:choose>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:template>
</xsl:stylesheet>
<!-- vim: set filetype=xslt tw=0 ts=2 sw=2 noet: -->
