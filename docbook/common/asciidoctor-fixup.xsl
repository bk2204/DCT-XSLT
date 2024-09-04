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

	<xsl:template match="db:*[(db:info|db:title) and
		count(db:para) = 0 and count(db:simpara) = 0
		and count(db:blockquote[not(@role = 'epigraph')]) = 1
		and db:blockquote/db:literallayout]">
		<xsl:copy>
			<xsl:apply-templates select="@*|db:*[not(local-name() = 'blockquote')]|db:blockquote[@role = 'epigraph']"/>
			<xsl:choose>
				<xsl:when test="db:blockquote[count(*) = 1]">
					<xsl:apply-templates select="db:blockquote[not(@role = 'epigraph')]/db:literallayout"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="db:blockquote"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="db:blockquote[@role = 'epigraph']">
		<xsl:element namespace="http://docbook.org/ns/docbook" name="epigraph">
			<xsl:copy>
				<xsl:apply-templates select="db:*"/>
			</xsl:copy>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
