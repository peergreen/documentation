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
	<xsl:template match="*" mode="admon.graphic.width">
	  <xsl:text>24pt</xsl:text>
	</xsl:template>
    <xsl:param name="admon.style">
      <xsl:text>margin-left: 0.5in; margin-right: 0.5in; background-color: DDFFDD;</xsl:text>
    </xsl:param>
    <xsl:param name="callout.graphics.path"><xsl:value-of select="$img.src.path" />images/callouts/</xsl:param>
    <!-- * enable navigational icons -->
    <xsl:param name="navig.graphics">1</xsl:param>
    <xsl:param name="navig.graphics.path"><xsl:value-of select="$img.src.path" />images/admons/</xsl:param>
    <xsl:param name="navig.graphics.extension">.png</xsl:param>
	<!-- no other header navigation (prev, next, etc.) -->
	<xsl:template name="header.navigation"/>
    <xsl:param name="navig.showtitles" select="1" />

    <!-- Labeling -->
    <xsl:param name="chapter.autolabel" select="1" />
    <xsl:param name="section.autolabel" select="1" />
    <xsl:param name="part.autolabel" select="'I'" />
    <xsl:param name="section.label.includes.component.label" select="1" />
    <xsl:param name="component.label.includes.part.label" select="1" />
	
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
        <div style="background-color:#333333;border:none;height:73px;border:1px solid black;padding-left:50px; padding-right:50px">
            <div style="float:left">
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
			<div style="float:right; padding-top:30px">
				<img>
					<xsl:attribute name="src">
						<xsl:value-of select="$img.src.path" />
						<xsl:text>images/community-documentation.png</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="border">
						<xsl:text>none</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="position">
						<xsl:text>absolute</xsl:text>
					</xsl:attribute>
					<xsl:attribute name="height">
						<xsl:text>40px</xsl:text>
					</xsl:attribute>
				</img>
			</div>
        </div>
    </xsl:template>
 
	<xsl:template match="db:programlisting[@language]" mode="class.value">
	  <xsl:param name="class" select="local-name(.)"/>
	  <xsl:variable name="lang" select="concat('lang-', @language, ' ')"/>
	  <xsl:choose>
		<xsl:when test="@linenumbering = 'linenums'">
		  <xsl:value-of select="concat('prettyprint ', $lang, 'linenums ', $class)"/>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:value-of select="concat('prettyprint ', $lang, $class)"/>
		</xsl:otherwise>
	  </xsl:choose>
	</xsl:template>
	
    <xsl:template name="user.footer.navigation">
		<xsl:param name="node" select="."/>
		<script>
			<xsl:attribute name="src">
				<xsl:value-of select="$img.src.path" />
				<xsl:text>highlighter/prettify.js</xsl:text>
			</xsl:attribute>
		</script>
		<script>prettyPrint();</script>
		
		<div style="width:100%;background-color:#DDFFDD;border:none;">
	  		<div style="margin:auto;"><p>Copyright © Peergreen <xsl:value-of select="db:info/db:copyright/db:year" /> All rights reserved.</p></div>
		</div>
	</xsl:template>
	
</xsl:stylesheet>
