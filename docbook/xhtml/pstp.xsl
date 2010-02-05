<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns="http://www.w3.org/1999/xhtml"
	exclude-result-prefixes="xsl xhtml">
	<xsl:import href="../htmllib/pstp.xsl" />
	<xsl:output method="xml" encoding="UTF-8" indent="no" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"/>
	<xsl:template match="@xml:lang" mode="ctxsl:all-xhtml2xhtml">
		<xsl:copy-of select="." />
	</xsl:template>
	<xsl:template match="*" mode="ctxsl:maybensnuke">
		<xsl:copy>
			<xsl:copy-of select="@*" />
			<xsl:apply-templates mode="ctxsl:maybensnuke" />
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
