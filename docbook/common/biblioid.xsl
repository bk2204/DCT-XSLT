<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://docbook.org/ns/docbook"
	xmlns:db="http://docbook.org/ns/docbook"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- We use an RFC 6920 ni URI here. -->
	<xsl:param name="hash-base64" />
	<xsl:param name="hash-name" />

	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="/db:*/db:info[not(db:biblioid)]">
		<xsl:copy>
			<xsl:apply-templates select="@*|*"/>
			<biblioid class="uri"><xsl:text>ni:///</xsl:text><xsl:value-of
					select="$hash-name"/><xsl:text>;</xsl:text><xsl:value-of
					select="$hash-base64"/>
			</biblioid>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
