<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="db:article[count(*) = 2 and
		db:info and db:blockquote/db:literallayout]">
		<xsl:copy>
			<xsl:apply-templates select="@*|db:info"/>
			<xsl:choose>
				<xsl:when test="db:blockquote[count(*) = 1]">
					<xsl:apply-templates select="db:blockquote/db:literallayout"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="db:blockquote"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
