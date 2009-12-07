<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
	Items that are imported first have the lowest priority, followed by
	later imports, followed by this sheet.
	-->
	<!-- Don't use graphics in admonitions. -->
	<xsl:param name="admon.graphics" select="0" />
	<!-- Use a text label (Note, Warning, etc.). -->
	<xsl:param name="admon.textlabel" select="1" />
	<!-- Don't generate an index; we'll never use it. -->
	<xsl:param name="generate.index" select="0" />
	<!-- Use ul for the TOC so that it will validate as XHTML5. -->
	<xsl:param name="toc.list.type" select="'ul'" />
	<!--
	Don't use the tablecolumns extension since we don't use saxon for processing,
	and therefore it won't work anyway. 
	-->
	<xsl:param name="tablecolumns.extension" select="0" />
	<!-- Use the better of two bad styles for cross-references. -->
	<xsl:param name="xref.with.number.and.title" select="0" />
	<!-- Output spiffy angle brackets around email addresses. -->
	<xsl:param name="email.delimiters.enabled" select="1" />
	<!-- Make copyright years into a range, even single years. -->
	<xsl:param name="make.year.ranges" select="1" />
	<xsl:param name="make.single.year.ranges" select="1" />
	<!--
	My middle name (or middle initial, to be more precise) is specified in
	othername.
	-->
	<xsl:param name="author.othername.in.middle" select="1" />
	<!-- Start numbering chapters anew in each part. -->
	<xsl:param name="label.from.part" select="1" />
	<!-- Use extensions for useful things. -->
	<xsl:param name="use.extensions" select="1" />
</xsl:stylesheet>
