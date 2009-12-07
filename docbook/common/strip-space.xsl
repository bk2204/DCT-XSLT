<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns="http://docbook.org/ns/docbook"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:strip-space elements="*"/>
	<xsl:preserve-space elements="db:address db:classsynopsisinfo db:funcsynopsisinfo db:literallayout db:programlisting db:programlistingco db:screen db:screenco db:synopsis" />
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="text()">
		<xsl:choose>
			<xsl:when test="ancestor::node()[db:address|db:classsynopsisinfo|db:funcsynopsisinfo|db:literallayout|db:programlisting|db:programlistingco|db:screen|db:screenco|db:synopsis]">
				<xsl:value-of select="."/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="normalize-space(.)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
