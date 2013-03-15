<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xslthl="http://xslthl.sf.net"
                exclude-result-prefixes="xslthl"
                version='1.0'>

    <!-- Imported stylesheet -->
    <xsl:import href="urn:docbkx:stylesheet" />
    <xsl:import href="highlight.xsl" />

    <xsl:output method="html" encoding="UTF-8" indent="yes" />

    <!-- Graphics options -->
    <xsl:param name="admon.graphics" select="1" />
    <xsl:param name="admon.graphics.path" select="'images/admons/'" />
    <xsl:param name="callout.graphics.path" select="'images/callouts/'" />
    <!-- * enable navigational icons -->
    <xsl:param name="navig.graphics">1</xsl:param>
    <xsl:param name="navig.graphics.path" select="'images/admons/'" />
    <xsl:param name="navig.graphics.extension">.png</xsl:param>
    <xsl:param name="navig.showtitles" select="1" />

    <!-- Labeling -->
    <xsl:param name="chapter.autolabel" select="1" />
    <xsl:param name="section.autolabel" select="1" />
    <xsl:param name="part.autolabel" select="'I'" />
    <xsl:param name="section.label.includes.component.label" select="1" />
    <xsl:param name="component.label.includes.part.label" select="1" />

    <!-- Chunks options -->
    <xsl:param name="chunker.output.indent" select="'yes'" />
    <xsl:param name="chunk.section.depth">2</xsl:param>
    <xsl:param name="use.id.as.filename" select="1" />

    <!-- TOC -->
    <xsl:param name="toc.section.depth">2</xsl:param>

    <!-- Misc. -->
    <xsl:param name="language">en</xsl:param>
    <xsl:param name="keep.relative.image.uris" select="1" />

</xsl:stylesheet>
