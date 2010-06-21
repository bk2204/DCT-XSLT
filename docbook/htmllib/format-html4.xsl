<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:ctxsl="http://crustytoothpaste.ath.cx/ns/xsl"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="ctxsl xsl">

	<xsl:template name="ctxsl:footer-cb">
		<xsl:call-template name="ctxsl:footer">
			<xsl:with-param name="ctxsl:structure">
				<a href="http://validator.w3.org/check/referer">HTML 4.01 Strict</a>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
