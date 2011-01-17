<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- By "free" here, we mean compliant to the DFSG. -->
	<xsl:param name="free.fonts.only" select="0"/>
	<xsl:param name="font.family.Courier.free"
		select="'Nimbus Mono L'" />
	<xsl:param name="font.family.Helvetica.free"
		select="'Nimbus Sans L'" />
	<xsl:param name="font.family.Times.free"
		select="'Nimbus Roman No9 L'" />
	<xsl:param name="font.family.Palatino.free"
		select="'URW Palladio L'" />
	<xsl:param name="font.family.Courier">
		<xsl:choose>
			<xsl:when test="$free.fonts.only != 0">
				<xsl:value-of select="$font.family.Courier.free"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Courier New,</xsl:text>
				<xsl:value-of select="$font.family.Courier.free"/>
				<xsl:text>,Courier</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="font.family.Helvetica">
		<xsl:choose>
			<xsl:when test="$free.fonts.only != 0">
				<xsl:value-of select="$font.family.Helvetica.free"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Helvetica,</xsl:text>
				<xsl:value-of select="$font.family.Helvetica.free"/>
				<xsl:text>,Arial</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="font.family.Garamond"
		select="'ITC Garamond,Garamond,URW Garamond,GaramondNo8'" />
	<xsl:param name="font.family.Times">
		<xsl:choose>
			<xsl:when test="$free.fonts.only != 0">
				<xsl:value-of select="$font.family.Times.free"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Times New Roman,</xsl:text>
				<xsl:value-of select="$font.family.Times.free"/>
				<xsl:text>,Times</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="font.family.Palatino">
		<xsl:choose>
			<xsl:when test="$free.fonts.only != 0">
				<xsl:value-of select="$font.family.Palatino.free"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>Palatino Linotype,</xsl:text>
				<xsl:value-of select="$font.family.Palatino.free"/>
				<xsl:text>,Palatino,Zapf Calligraphic,Book Antiqua</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:param>
	<xsl:param name="font.family.Minion"
		select="'Minion Pro'" />
</xsl:stylesheet>
