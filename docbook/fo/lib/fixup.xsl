<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!--
		No released version of fop supports catalog resolving, so resolve to a
		local location until this is fixed.
		-->
	<xsl:param name="draft.watermark.image">file:///usr/share/xml/docbook/stylesheet/docbook-xsl-ns/images/draft.png</xsl:param>

	<!-- Avoid a needless change of font in printed format. -->
	<xsl:template match="db:systemitem">
		<xsl:call-template name="inline.charseq"/>
	</xsl:template>
</xsl:stylesheet>
