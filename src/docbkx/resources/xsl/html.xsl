<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xslthl="http://xslthl.sf.net"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="xslthl"
                version='1.0'>

    <xsl:import href="urn:docbkx:stylesheet"/>
    <xsl:import href="highlight.xsl"/>
    
    <!--==============================================-->
    <!--                HTML Settings                 -->
    <!--==============================================-->

    <!-- These extensions are required for table printing and other stuff -->
    <xsl:param name="tablecolumns.extension">0</xsl:param>
    <xsl:param name="graphicsize.extension">0</xsl:param>
    <xsl:param name="ignore.image.scaling">1</xsl:param>

    <xsl:output method="html" encoding="UTF-8" indent="yes" />
    
    <!--  use graphics in admonitions -->
	<xsl:param name="admon.graphics" select="1" />
	<xsl:param name="admon.graphics.path"><xsl:value-of select="$img.src.path" />images/admons/</xsl:param>
	<xsl:param name="admon.graphics.extension">.png</xsl:param>
	<xsl:param name="admon.style">
      <xsl:text>margin-left: 0.5in; margin-right: 0.5in; background-color: 99FF99;</xsl:text>
    </xsl:param>
	
    <xsl:param name="callout.graphics.path" select="'images/callouts/'" />
    <!--  chapters will be numbered -->
    <xsl:param name="chapter.autolabel" select="1" />
    
	<!-- Remove "Chapter" from the Chapter titles... -->
    <xsl:param name="local.l10n.xml" select="document('')"/>
    <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    	<l:l10n language="en">
            <l:context name="title-numbered">
                <l:template name="chapter" text="%n.&#160;%t"/>
                <l:template name="section" text="%n&#160;%t"/>
            </l:context>
        </l:l10n>
    </l:i18n>
    
    <!--  sections will be numbered -->
    <xsl:param name="section.autolabel" select="1" />
    <!--  section numbers will include the chapter number -->
    <xsl:param name="section.label.includes.component.label" select="1" />
    <!--  parts will be numbered (Uppercase roman numeration )  -->
    <xsl:param name="part.autolabel" select="'I'"></xsl:param>
    <!--  component labels include the part label  -->
    <xsl:param name="component.label.includes.part.label" select="1"></xsl:param>
    <!--  empty paragraphs will be inserted in several contexts -->
    <xsl:param name="spacing.paras" select="'1'"></xsl:param>
    <!-- depth to which recursive sections should appear in the TOC -->
    <xsl:param name="toc.section.depth">2</xsl:param>
    <xsl:param name="simplesect.in.toc" select="0"></xsl:param>
    <!--
      - fix the build for thoses who couldn't build
      - the doc anymore -->
    <xsl:param name="language">en</xsl:param>
    <xsl:param name="annotation.support" select="1"></xsl:param>

    <xsl:param name="keep.relative.image.uris" select="0"></xsl:param>

    <xsl:param name="generate.toc">
      book      toc
      chapter   toc
    </xsl:param>	
    
    <!--==============================================-->
    <!--             Headers and Footers			  -->
    <!--==============================================-->
    
 	<xsl:template name="user.header.content">
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
    
    <xsl:template name="user.footer.content">
	  <div style="width:100%;background-color:#A9FF9E;border:none;">
	  		<div style="margin:auto;"><p>Copyright © Peergreen <xsl:value-of select="db:info/db:copyright/db:year" /> All rights reserved.</p></div>
	  </div>
	</xsl:template>

</xsl:stylesheet>
