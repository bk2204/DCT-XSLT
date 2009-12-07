<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:dbx="http://docbook.org/ns/docbook"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:exsl="http://exslt.org/common"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="number" select="1000000"/>
	<xsl:param name="index" select="0"/>
	<xsl:template match="node()|@*">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="dbx:phrase">
		<xsl:if test="(@condition='index' and $index) or
			(@condition='entries' and not($index)) or not(@condition)">
			<xsl:copy>
				<xsl:apply-templates select="@*[local-name()!='condition']"/>
				<xsl:apply-templates select="node()"/>
			</xsl:copy>
		</xsl:if>
	</xsl:template>
	<xsl:template match="dbx:book|dbx:part">
			<xsl:variable name="articles">
				<xsl:for-each select=".//dbx:article">
					<xsl:sort select="dbx:info/dbx:date" lang="en" order="descending" />
					<xsl:sort select="dbx:info/dbx:title" lang="en" order="descending" />
					<xsl:variable name="permalink" select="./dbx:info/dbx:releaseinfo/dbx:link/@xlink:href" />
					<xsl:if test="not(preceding::dbx:article/dbx:info/dbx:releaseinfo/dbx:link/@xlink:href = $permalink)">
							<xsl:apply-templates select="."/>
					</xsl:if>
				</xsl:for-each>
			</xsl:variable>
		<xsl:copy>
			<xsl:apply-templates select="dbx:info" />
			<xsl:apply-templates select="dbx:preface" />
			<xsl:for-each select="exsl:node-set($articles)">
				<xsl:for-each select=".//dbx:article">
					<xsl:if test="position()&lt;=$number">
						<xsl:apply-templates select="."/>
					</xsl:if>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
