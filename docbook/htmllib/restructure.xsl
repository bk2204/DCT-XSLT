<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xi="http://www.w3.org/2003/XInclude"
	xmlns:xh="http://www.w3.org/1999/xhtml"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:cc="http://creativecommons.org/ns#"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="db xlink ctxsl xsl xi xh dc cc rdf">

	<!-- 
		The idea of this stylesheet is to restructure the DocBook output slightly
		so we get a more useful structural framework for styling.

		The body has two components: div#content and div#footer.  div#content has
		div.toplevel, which also has a class of article, book, etc. as the case may
		be.  Every DocBook article, book, section, etc. has two components:
		div.titlepage and div.flow.  The first such pair, which will be located
		directly in div.toplevel, has IDs of div#header and div#main, respectively.
	-->

	<!-- Add a class to those that are already there. -->
	<xsl:template name="ctxsl:add-class">
		<xsl:param name="ctxsl:class"/>
		<xsl:attribute name="class">
			<xsl:value-of select="concat(@class, ' ', $ctxsl:class)"/>
		</xsl:attribute>
		<xsl:apply-templates select="@*[not(name(.) = 'class')]"
			mode="ctxsl:all-xhtml2xhtml"/>
	</xsl:template>

	<xsl:template match="xh:*" mode="ctxsl:copy-parent-class">
		<xsl:copy>
			<xsl:call-template name="ctxsl:add-class">
				<xsl:with-param name="ctxsl:class">
					<xsl:value-of select="../@class"/>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:apply-templates select="node()" mode="ctxsl:all-xhtml2xhtml"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="xh:body/xh:div[not(@class = 'footer')]"
		mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:call-template name="ctxsl:add-class">
				<xsl:with-param name="ctxsl:class">toplevel</xsl:with-param>
			</xsl:call-template>
			<xsl:apply-templates select="xh:div[@class = 'titlepage']"
				mode="ctxsl:all-xhtml2xhtml"/>
			<xsl:apply-templates select="xh:div[@class = 'toc']"
				mode="ctxsl:all-xhtml2xhtml"/>
			<div id="main" class="flow">
				<xsl:apply-templates
					select="xh:*[not((@class = 'titlepage') or (@class = 'toc'))]"
					mode="ctxsl:all-xhtml2xhtml"/>
			</div>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="xh:div[@class='literallayout' or @class='address']"
		mode="ctxsl:all-xhtml2xhtml">
		<xsl:apply-templates mode="ctxsl:copy-parent-class"/>
	</xsl:template>

	<xsl:template match="xh:body" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<div class="content">
				<xsl:apply-templates select="node()" mode="ctxsl:all-xhtml2xhtml"/>
			</div>
			<xsl:call-template name="ctxsl:footer-cb"/>
		</xsl:copy>
	</xsl:template>


	<xsl:template
		match="xh:body/xh:div[not(@class = 'footer')]/xh:div[@class = 'titlepage']"
		mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:attribute name="id">header</xsl:attribute>
			<xsl:apply-templates select="@*|node()" mode="ctxsl:all-xhtml2xhtml" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="xh:div[@class and ./xh:div[@class = 'titlepage']
		and not(local-name(..)='body')]"
		mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<!--
				Move the ID out from the a element in the title to the main element.
			-->
			<xsl:if test="xh:div[@class='titlepage']//xh:*[@class='title']/xh:a[@id]">
				<xsl:attribute name="id">
					<xsl:value-of
						select="xh:div[@class='titlepage']//xh:*[@class='title']/xh:a/@id"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="@*" mode="ctxsl:all-xhtml2xhtml"/>
			<!-- Split out into .titlepage and .flow. -->
			<xsl:apply-templates select="xh:div[@class = 'titlepage']"
				mode="ctxsl:all-xhtml2xhtml"/>
			<div class="flow">
				<xsl:apply-templates select="xh:*[not(@class = 'titlepage')]"
					mode="ctxsl:all-xhtml2xhtml"/>
			</div>
		</xsl:copy>
	</xsl:template>

	<!-- Fix up colophons so that they act like articles. -->
	<xsl:template match="xh:div[@class = 'colophon']"
		mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:copy-of select="@*"/>
			<xsl:if test="not(@id)">
				<xsl:attribute name="id">
					<xsl:text>colophon</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<div class="titlepage">
				<xsl:apply-templates select="xh:*[@class = 'title']"
					mode="ctxsl:all-xhtml2xhtml"/>
			</div>
			<div class="flow">
				<xsl:apply-templates select="xh:*[not(@class = 'title')]"
					mode="ctxsl:all-xhtml2xhtml"/>
			</div>
		</xsl:copy>
	</xsl:template>

	<!-- Acknowledgements should be a full div. -->
	<xsl:template match="xh:p[@class='acknowledgements']"
		mode="ctxsl:all-xhtml2xhtml">
		<div class="acknowledgements">
			<xsl:apply-templates mode="ctxsl:all-xhtml2xhtml"/>
		</div>
	</xsl:template>

	<!--
	Dummy implementation of the footer callback.
	-->
	<xsl:template name="ctxsl:footer-cb"/>
</xsl:stylesheet>
