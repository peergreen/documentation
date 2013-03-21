<?xml version='1.0'?>
<!--
    Simple highlighter for FO/PDF output. Follows the Eclipse color scheme.
    Comes from SpringSource build process
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:xslthl="http://xslthl.sf.net"
                exclude-result-prefixes="xslthl"
                version='1.0'>

  <xsl:template match='xslthl:keyword' mode="xslthl">
    <fo:inline font-weight="bold" color="#7F0055">
      <xsl:apply-templates mode="xslthl"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match='xslthl:comment' mode="xslthl">
    <fo:inline font-style="italic" color="#3F5F5F">
      <xsl:apply-templates mode="xslthl"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match='xslthl:oneline-comment' mode="xslthl">
    <fo:inline font-style="italic" color="#3F5F5F">
      <xsl:apply-templates mode="xslthl"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match='xslthl:multiline-comment' mode="xslthl">
    <fo:inline font-style="italic" color="#3F5FBF">
      <xsl:apply-templates mode="xslthl"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match='xslthl:tag' mode="xslthl">
    <fo:inline color="#3F7F7F">
      <xsl:apply-templates mode="xslthl"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match='xslthl:attribute' mode="xslthl">
    <fo:inline color="#7F007F">
      <xsl:apply-templates mode="xslthl"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match='xslthl:value' mode="xslthl">
    <fo:inline color="#2A00FF">
      <xsl:apply-templates mode="xslthl"/>
    </fo:inline>
  </xsl:template>

  <xsl:template match='xslthl:string' mode="xslthl">
    <fo:inline color="#2A00FF">
      <xsl:apply-templates mode="xslthl"/>
    </fo:inline>
  </xsl:template>

</xsl:stylesheet>
