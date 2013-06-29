<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="ctxsl xsl">

	<xsl:import href="format-xhtml.xsl"/>

	<xsl:variable name="ctxsl:id-name">xml:id</xsl:variable>
	<xsl:variable name="ctxsl:id-ns">http://www.w3.org/XML/1998/namespace</xsl:variable>

	<xsl:template name="ctxsl:xhtml-version" />

	<xsl:template match="@border" mode="ctxsl:all-xhtml2xhtml"/>

	<xsl:template match="@id" mode="ctxsl:all-xhtml2xhtml">
		<xsl:attribute name="xml:id"
			namespace="http://www.w3.org/XML/1998/namespace">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>

	<xsl:template name="ctxsl:load-meta-links">
		<xsl:if test="count(//xhtml:head/xhtml:link[@rel='meta']) >= 1">
			<rdf:RDF>
				<rdf:Description rdf:about="">
					<xsl:for-each select="//xhtml:head/xhtml:link[@rel='meta']">
						<rdf:seeAlso rdf:resource="{@href}"/>
					</xsl:for-each>
				</rdf:Description>
			</rdf:RDF>
		</xsl:if>
	</xsl:template>

	<xsl:template match="xhtml:head/xhtml:link[@rel='meta']"
		mode="ctxsl:all-xhtml2xhtml"/>

	<xsl:template match="rdf:RDF" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:copy-of select="@*[name()!='xml:base']|*"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template name="ctxsl:insert-xml-id-js">
		<script>
			//<![CDATA[
			// Make id attributes for browsers that don't understand xml:id.
			(function () {
				var id_fixup = function () {
					var xml_ns = "http://www.w3.org/XML/1998/namespace";
					if (document.getElementById("content"))
						return;
					var treewalker = document.createTreeWalker(
						document.body,
						NodeFilter.SHOW_ELEMENT,
						{
							acceptNode: function(node) {
								return node.getAttributeNS(xml_ns, "id") ?
									NodeFilter.FILTER_ACCEPT : NodeFilter.FILTER_SKIP;
							}
						},
						false
					);
					while (treewalker.nextNode()) {
						var cur = treewalker.currentNode;
						var value = cur.getAttributeNS(xml_ns, "id");
						// Only one ID attribute can be present, and for this browser it's
						// the HTML one.
						cur.removeAttributeNS(xml_ns, "id");
						cur.setAttributeNS(null, "id", value);

					}
				};
				window.addEventListener("load", id_fixup, false);
			})();
			//]]>
		</script>
	</xsl:template>

	<xsl:template match="xhtml:head" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:apply-templates mode="ctxsl:all-xhtml2xhtml" />
			<xsl:call-template name="ctxsl:load-meta-links"/>
			<xsl:call-template name="ctxsl:insert-xml-id-js"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="xhtml:colgroup[@span][xhtml:col[@span]]"
		mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy>
			<xsl:apply-templates select="@*[name()!='span']|*"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="xhtml:th/xhtml:p" mode="ctxsl:all-xhtml2xhtml">
		<xsl:apply-templates select="node()"/>
	</xsl:template>

	<xsl:template match="xhtml:acronym">
		<abbr>
			<xsl:copy>
				<xsl:apply-templates select="@*|node()"/>
			</xsl:copy>
		</abbr>
	</xsl:template>

	<xsl:template match="@cellspacing|@cellpadding|@summary"/>

	<xsl:template name="ctxsl:footer-cb">
		<xsl:call-template name="ctxsl:footer">
			<xsl:with-param name="ctxsl:structure">
				<a href="http://validator.w3.org/check/referer">XHTML 5</a>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
