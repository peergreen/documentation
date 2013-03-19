<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xslthl="http://xslthl.sf.net"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="xslthl"
                version='1.0'>

    <!-- Imported stylesheet -->
    <xsl:import href="urn:docbkx:stylesheet" />
    <xsl:import href="highlight.xsl" />

    <xsl:output method="html" encoding="UTF-8" indent="yes" />

    <!-- Graphics options -->
    <xsl:param name="admon.graphics" select="1" />
    <xsl:param name="admon.graphics.path"><xsl:value-of select="$img.src.path" />images/admons/</xsl:param>
    <xsl:param name="admon.graphics.extension">.png</xsl:param>
    <xsl:param name="admon.style">
      <xsl:text>margin-left: 0.5in; margin-right: 0.5in; background-color: 99FF99;</xsl:text>
    </xsl:param>
    <xsl:param name="callout.graphics.path"><xsl:value-of select="$img.src.path" />images/callouts/</xsl:param>
    <!-- * enable navigational icons -->
    <xsl:param name="navig.graphics">1</xsl:param>
    <xsl:param name="navig.graphics.path"><xsl:value-of select="$img.src.path" />images/admons/</xsl:param>
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
    
    <!--==============================================-->
    <!--             Headers and Footers			  -->
    <!--==============================================-->
    
 	<xsl:template name="user.header.navigation">
        <div style="background-color:#333333;border:none;height:73px;border:1px solid black;padding-left:50px">
            <a style="border:none;" href="http://www.peergreen.com/" title="Peergreen">
                <img>
                	<xsl:attribute name="src">
                		<xsl:value-of select="$img.src.path" />
                		<xsl:text>images/peergreen-logo-white.png</xsl:text>
                	</xsl:attribute>
                	<xsl:attribute name="border">
                		<xsl:text>none</xsl:text>
                	</xsl:attribute>
                	<xsl:attribute name="position">
                		<xsl:text>absolute</xsl:text>
                	</xsl:attribute>
                	<xsl:attribute name="height">
                		<xsl:text>70px</xsl:text>
                	</xsl:attribute>
                </img>
            </a>
        </div>
    </xsl:template>
    
    <xsl:template name="user.footer.navigation">
	  <div style="width:100%;background-color:#A9FF9E;border:none;">
	  		<div style="margin:auto;"><p>Copyright © Peergreen <xsl:value-of select="db:info/db:copyright/db:year" /> All rights reserved.</p></div>
	  </div>
	</xsl:template>

</xsl:stylesheet>
