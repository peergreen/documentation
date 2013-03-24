<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xslthl="http://xslthl.sf.net"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="xslthl"
                version='1.0'>

  <!-- Imported stylesheet -->
  <xsl:import href="urn:docbkx:stylesheet"/>

  <!-- Graphics options -->
  <xsl:param name="admon.graphics" select="1"/>
  <xsl:param name="admon.graphics.path">../images/admons/</xsl:param>
  <xsl:param name="admon.graphics.extension">.png</xsl:param>
  <xsl:param name="callout.graphics.path">../images/callouts/</xsl:param>
  <!-- * enable navigational icons -->
  <xsl:param name="navig.graphics">1</xsl:param>
  <xsl:param name="navig.graphics.path">../images/admons/</xsl:param>
  <xsl:param name="navig.graphics.extension">.png</xsl:param>
  <!-- no other header navigation (prev, next, etc.) -->
  <xsl:template name="header.navigation"/>
  <xsl:param name="navig.showtitles" select="1"/>

  <!-- Labeling -->
  <xsl:param name="chapter.autolabel" select="1"/>
  <xsl:param name="section.autolabel" select="1"/>
  <xsl:param name="part.autolabel" select="'I'"/>
  <xsl:param name="section.label.includes.component.label" select="1"/>
  <xsl:param name="component.label.includes.part.label" select="1"/>

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
  <xsl:param name="chunker.output.indent" select="'yes'"/>
  <xsl:param name="chunk.section.depth">2</xsl:param>
  <xsl:param name="use.id.as.filename" select="1"/>

  <!-- TOC -->
  <xsl:param name="toc.section.depth">2</xsl:param>

  <!-- Misc. -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="keep.relative.image.uris" select="1"/>

  <!--==============================================-->
  <!--             Headers and Footers			  -->
  <!--==============================================-->

  <xsl:template name="user.header.navigation">
    <div
        style="background-color:#333333;border:none;height:73px;padding-left:50px; padding-right:50px">
      <div style="float:left">
        <a style="border:none;" href="http://www.peergreen.com/" title="Peergreen">
          <img src="../images/peergreen-logo-white.png"
               style="border:none;height:70px"/>
        </a>
      </div>
      <div style="float:right; padding-top:30px">
        <img src="../images/community-documentation.png"
             style="border:none;height:40px"/>
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
    <script src="../js/prettify.js"/>
    <script>prettyPrint();</script>

    <div style="width:100%;background-color:#DDFFDD;border:none;">
      <div style="margin:auto;">
        <p>Copyright © Peergreen
          <xsl:value-of select="db:info/db:copyright/db:year"/> All rights reserved.
        </p>
      </div>
    </div>
  </xsl:template>

</xsl:stylesheet>
