<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="db"
                version='1.0'>

  <xsl:import href="urn:docbkx:stylesheet"/>
  <xsl:import href="urn:docbkx:stylesheet/highlight.xsl"/>
  <xsl:import href="highlight-fo.xsl"/>

  <!--==============================================-->
  <!--             Custom Title Page                -->
  <!--==============================================-->

  <xsl:template name="book.titlepage.recto">
    <fo:block>
      <fo:table table-layout="fixed" width="175mm">
        <fo:table-column column-width="175mm"/>
        <fo:table-body>
          <fo:table-row height="30mm">
            <fo:table-cell text-align="center" display-align="before">
              <fo:block>
                <fo:external-graphic>
                  <xsl:attribute name="src">
                    <xsl:value-of select="$img.src.path"/>
                    <xsl:text>images/pg_banner.png</xsl:text>
                  </xsl:attribute>
                </fo:external-graphic>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
          <fo:table-row height="120mm">
            <fo:table-cell text-align="center" display-align="center">
              <fo:block font-size="32pt" padding-before="10mm">
                <xsl:value-of select="db:info/db:title"/>
              </fo:block>
              <fo:block font-size="12pt" font-style="italic" padding="10mm">
                <xsl:value-of select="db:info/db:abstract"/>
              </fo:block>
              <fo:block font-size="12pt" padding="10mm">
                <xsl:value-of select="db:info/db:releaseinfo"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
          <fo:table-row height="40mm">
            <fo:table-cell text-align="center" display-align="after">
              <xsl:if test="count(db:info/db:authorgroup/*) &gt; 0">
                <fo:block font-size="10pt">
                  <xsl:text>(</xsl:text>
                  <xsl:for-each select="db:info/db:authorgroup/db:author">
                    <!-- Add a comma for all elements except the first -->
                    <xsl:if test="position() &gt; 1">
                      <xsl:text>, </xsl:text>
                    </xsl:if>
                    <xsl:value-of select="db:personname"/>
                  </xsl:for-each>
                  <xsl:text>)</xsl:text>
                </fo:block>
              </xsl:if>

              <fo:block font-size="8pt" padding="2mm">
                <xsl:text>- </xsl:text>
                <xsl:value-of select="db:info/db:date"/>
                <xsl:text> -</xsl:text>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
          <fo:table-row height="30mm">
            <fo:table-cell text-align="center" display-align="after">
              <fo:block font-size="12pt" padding="10mm">
                <xsl:text>Copyright &#169; </xsl:text>
                <xsl:value-of select="db:info/db:copyright/db:holder"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="db:info/db:copyright/db:year"/>
              </fo:block>
              <fo:block font-size="10pt" padding="1mm">
                <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode"
                                     select="db:info/db:legalnotice"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>

        </fo:table-body>
      </fo:table>
    </fo:block>
  </xsl:template>

  <!-- Prevent blank pages in output -->
  <xsl:template name="book.titlepage.before.verso"></xsl:template>
  <xsl:template name="book.titlepage.verso"></xsl:template>
  <xsl:template name="book.titlepage.separator"></xsl:template>

  <!--==============================================-->
  <!--                 Extensions                   -->
  <!--==============================================-->

  <!-- These extensions are required for table printing and other stuff -->
  <xsl:param name="tablecolumns.extension">0</xsl:param>
  <xsl:param name="ignore.image.scaling">0</xsl:param>
  <!-- for getting bookmarks in pdf document -->
  <xsl:param name="fop1.extensions" select="1"/>

  <!-- Body font -->
  <xsl:param name="body.font.family">Calibri</xsl:param>
  <xsl:param name="title.font.family">Calibri</xsl:param>
  <xsl:param name="monospace.font.family">SourceCodePro</xsl:param>

  <!--==============================================-->
  <!--        		Table of Contents				-->
  <!--==============================================-->

  <xsl:param name="generate.toc">
    book      toc,title
    chapter   toc
  </xsl:param>

  <!--==============================================-->
  <!--    	  			Header						-->
  <!--==============================================-->

  <xsl:attribute-set name="header.content.properties">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$body.font.family"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <!--==============================================-->
  <!--    	  		Custom Header					-->
  <!--==============================================-->
  
  <!-- More space in the right header for long text -->
  <xsl:param name="header.column.widths">1 1 3</xsl:param>
  <xsl:param name="header.table.height">20pt</xsl:param>

  <xsl:template name="header.content">
    <xsl:param name="pageclass" select="''"/>
    <xsl:param name="sequence" select="''"/>
    <xsl:param name="position" select="''"/>
    <xsl:param name="gentext-key" select="''"/>

    <xsl:choose>
      <xsl:when test="$position='left'">
        <fo:external-graphic height="20pt"
                             content-height="scale-to-fit"
                             content-width="scale-to-fit">
          <xsl:attribute name="src">
            <xsl:value-of select="$img.src.path"/>
            <xsl:text>images/logo-peergreen.png</xsl:text>
          </xsl:attribute>
        </fo:external-graphic>
      </xsl:when>
      <xsl:when test="$position='right'">
        <xsl:apply-templates select="." mode="object.title.markup"/>
      </xsl:when>
    </xsl:choose>
  </xsl:template>


  <!--==============================================-->
  <!--               Custom Footer                  -->
  <!--==============================================-->

  <!-- This footer prints the version number on the left side -->
  <xsl:template name="footer.content">
    <xsl:param name="pageclass" select="''"/>
    <xsl:param name="sequence" select="''"/>
    <xsl:param name="position" select="''"/>
    <xsl:param name="gentext-key" select="''"/>

    <xsl:variable name="info.version">
      <xsl:if test="//db:info/db:releaseinfo">
        <xsl:value-of select="//db:info/db:productname"/>
        <xsl:text> (</xsl:text>
        <xsl:value-of select="//db:info/db:releaseinfo"/>
        <xsl:text>)</xsl:text>
      </xsl:if>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$sequence='blank'">
        <xsl:if test="$position = 'center'">
          <xsl:value-of select="$info.version"/>
        </xsl:if>
      </xsl:when>
      <!-- for double sided printing, print page numbers on alternating sides (of the page) -->
      <xsl:when test="$double.sided != 0">
        <xsl:choose>
          <xsl:when test="$sequence = 'even' and $position='left'">
            <fo:page-number/>
          </xsl:when>
          <xsl:when test="$sequence = 'odd' and $position='right'">
            <fo:page-number/>
          </xsl:when>
          <xsl:when test="$position = 'center'">
            <xsl:value-of select="$info.version"/>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <!-- for single sided printing, print all page numbers on the right (of the page) -->
      <xsl:when test="$double.sided = 0">
        <xsl:choose>
          <xsl:when test="$position = 'center'">
            <xsl:value-of select="$info.version"/>
          </xsl:when>
          <xsl:when test="$position = 'right'">
            <fo:page-number/>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>


  <!-- Have chapter titles in bold. (from autotoc.xsl)-->
  <xsl:template name="toc.line">
    <xsl:param name="toc-context" select="NOTANODE"/>
   
    <xsl:variable name="id">
      <xsl:call-template name="object.id"/>
    </xsl:variable>
   
    <xsl:variable name="label">
      <xsl:apply-templates select="." mode="label.markup"/>
    </xsl:variable>
   
    <fo:block xsl:use-attribute-sets="toc.line.properties">

      <!-- peergreen -->
      <xsl:choose>
        <xsl:when test="self::db:chapter or self::db:appendix">
          <xsl:attribute name="font-weight">bold</xsl:attribute>
          <xsl:attribute name="margin-top">2.5mm</xsl:attribute>
        </xsl:when>
      </xsl:choose>

      <xsl:if test="local-name($toc-context) = 'db:chapter'">
        <xsl:attribute name="font-size">12pt</xsl:attribute>
      </xsl:if>
      <!-- /peergreen -->

      <fo:inline keep-with-next.within-line="always">
        <fo:basic-link internal-destination="{$id}">
          <xsl:if test="$label != ''">
            <xsl:copy-of select="$label"/>
            <xsl:value-of select="$autotoc.label.separator"/>
          </xsl:if>
          <xsl:apply-templates select="." mode="titleabbrev.markup"/>
        </fo:basic-link>
      </fo:inline>
      <fo:inline keep-together.within-line="always">
        <xsl:text> </xsl:text>
        <fo:leader leader-pattern="dots"
                   leader-pattern-width="3pt"
                   leader-alignment="reference-area"
                  keep-with-next.within-line="always"/>
      <xsl:text> </xsl:text>
      <fo:basic-link internal-destination="{$id}">
        <fo:page-number-citation ref-id="{$id}"/>
      </fo:basic-link>
    </fo:inline>
  </fo:block>
  </xsl:template>

  <!-- ==================================================================== -->
  <!-- Custom chapter title.                                                -->
  <!-- ==================================================================== -->

  <xsl:template match="db:title" mode="chapter.titlepage.recto.auto.mode"> 
    <fo:block  xsl:use-attribute-sets="chapter.titlepage.recto.style" 
               margin-left="{$title.margin.left}" 
               font-size="32.0pt" 
               font-weight="bold" 
               font-family="{$title.font.family}">
      <xsl:call-template name="peergreen.chapter.title">
        <xsl:with-param name="node" select="ancestor-or-self::db:chapter[1]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:template>


  <xsl:template name="peergreen.chapter.title">
    <xsl:param name="node" select="."/>
    <xsl:variable name="id">
      <xsl:call-template name="object.id">
        <xsl:with-param name="object" select="$node"/>
      </xsl:call-template>
    </xsl:variable>
   
    <fo:block id="chapter-{$id}" xsl:use-attribute-sets="chapter.label.properties">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key">
          <xsl:choose>
            <xsl:when test="$node/self::db:chapter">chapter</xsl:when>
            <xsl:when test="$node/self::db:appendix">appendix</xsl:when>
          </xsl:choose>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:text> </xsl:text>
      <xsl:apply-templates select="$node" mode="label.markup"/>
    </fo:block>
    <fo:block xsl:use-attribute-sets="chapter.title.properties">
      <xsl:apply-templates select="$node" mode="title.markup"/>
    </fo:block>
  </xsl:template>

  <!-- The formatting properties for the chapter label. -->
  <xsl:attribute-set name="chapter.label.properties">
    <xsl:attribute name="font-size">36pt</xsl:attribute>
    <xsl:attribute name="text-align">right</xsl:attribute>
    <xsl:attribute name="space-before.minimum">4cm</xsl:attribute>
    <xsl:attribute name="space-before.optimum">6cm</xsl:attribute>
    <xsl:attribute name="space-before.maximum">8cm</xsl:attribute>
  </xsl:attribute-set>

  <!-- The formatting properties for the chapter title. -->
  <xsl:attribute-set name="chapter.title.properties">
    <xsl:attribute name="font-size">48pt</xsl:attribute>
    <xsl:attribute name="text-align">right</xsl:attribute>
    <xsl:attribute name="space-before.minimum">2cm</xsl:attribute>
    <xsl:attribute name="space-before.optimum">4cm</xsl:attribute>
    <xsl:attribute name="space-before.maximum">6cm</xsl:attribute>
    <xsl:attribute name="space-after.minimum">2cm</xsl:attribute>
    <xsl:attribute name="space-after.optimum">3cm</xsl:attribute>
    <xsl:attribute name="space-after.maximum">4cm</xsl:attribute>
    <xsl:attribute name="hyphenate">false</xsl:attribute>
  </xsl:attribute-set>
 
  <!-- Other parameters -->

  <xsl:param name="paper.type" select="'A4'"/>
  <xsl:param name="double.sided">0</xsl:param>
  <xsl:param name="headers.on.blank.pages">0</xsl:param>
  <xsl:param name="footers.on.blank.pages">0</xsl:param>

  <!-- Space between paper border and content (chaotic stuff, don't touch) -->
  <xsl:param name="page.margin.top">10mm</xsl:param>
  <xsl:param name="page.margin.bottom">15mm</xsl:param>
  <xsl:param name="page.margin.outer">18mm</xsl:param>
  <xsl:param name="page.margin.inner">18mm</xsl:param>

  <xsl:param name="body.margin.top">15mm</xsl:param>
  <xsl:param name="body.margin.bottom">15mm</xsl:param>

  <xsl:param name="region.before.extent">10mm</xsl:param>
  <xsl:param name="region.after.extent">10mm</xsl:param>

  <!-- No indentation of body text -->
  <xsl:param name="body.start.indent">0pt</xsl:param>

  <!-- No indentation of Titles -->
  <xsl:param name="title.margin.left">0pc</xsl:param>

  <!--==============================================-->
  <!--               Fonts & Styles                 -->
  <!--==============================================-->

  <!-- Left aligned text and no hyphenation -->
  <xsl:param name="alignment">justify</xsl:param>
  <xsl:param name="hyphenate">false</xsl:param>

  <!--  use graphics in admonitions -->
  <xsl:param name="admon.graphics" select="1"/>
  <xsl:param name="admon.graphics.path"><xsl:value-of select="$img.src.path"/>images/admons/</xsl:param>
  <xsl:attribute-set name="graphical.admonition.properties">
    <xsl:attribute name="background-color">#f4f4f4</xsl:attribute>
    <xsl:attribute name="border-width">0.5px</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="border-color">#000000</xsl:attribute>

    <xsl:attribute name="padding-top">0.5em</xsl:attribute>
    <xsl:attribute name="padding-left">0.5em</xsl:attribute>
    <xsl:attribute name="padding-right">0.5em</xsl:attribute>
    <xsl:attribute name="padding-bottom">0.5em</xsl:attribute>

  </xsl:attribute-set>

  <xsl:template match="*" mode="admon.graphic.width">
    <xsl:text>22pt</xsl:text>
  </xsl:template>

  <!-- Fix the value, otherwise an HTTP URL was provided by default -->
  <xsl:param name="draft.watermark.image"><xsl:value-of select="$img.src.path"/>images/admons/draft.png</xsl:param>

  <!-- don't use graphics for callout -->
  <xsl:param name="callout.graphics" select="0"/>
  <!-- depth to which recursive sections should appear in the TOC -->
  <xsl:param name="toc.section.depth">2</xsl:param>
  <!--  chapters will be numbered -->
  <xsl:param name="chapter.autolabel" select="1"/>
  <!--  sections will be numbered -->
  <xsl:param name="section.autolabel" select="1"/>
  <!--  section numbers will include the chapter number -->
  <xsl:param name="section.label.includes.component.label" select="1"/>

  <!-- ProgramListing/Screen has a background color -->
  <xsl:param name="shade.verbatim">1</xsl:param>
  <xsl:attribute-set name="shade.verbatim.style">
    <xsl:attribute name="background-color">#f8f8fc</xsl:attribute>
  </xsl:attribute-set>

  <!-- Reduce size of program listing font and add a border -->
  <xsl:attribute-set name="verbatim.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 0.80"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute>
    <!--xsl:attribute name="font-family">SourceCodePro</xsl:attribute-->
    <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
    <xsl:attribute name="border-width">0.5px</xsl:attribute>
    <xsl:attribute name="border-style">solid</xsl:attribute>
    <xsl:attribute name="border-color">#000000</xsl:attribute>
    <xsl:attribute name="padding-top">0.5em</xsl:attribute>
    <xsl:attribute name="padding-left">0.5em</xsl:attribute>
    <xsl:attribute name="padding-right">0.5em</xsl:attribute>
    <xsl:attribute name="padding-bottom">0.5em</xsl:attribute>
    <xsl:attribute name="margin-left">0.5em</xsl:attribute>
    <xsl:attribute name="margin-right">0.5em</xsl:attribute>
  </xsl:attribute-set>
  <!-- Allow to wrap long lines for program listing -->
  <!--
    <xsl:param name="hyphenate.verbatim" select="1"/>
    -->
  <xsl:attribute-set name="monospace.verbatim.properties">
    <xsl:attribute name="font-size">
      <xsl:value-of select="$body.font.master * 0.80"/>
      <xsl:text>pt</xsl:text>
    </xsl:attribute> 
    <xsl:attribute name="wrap-option">wrap</xsl:attribute>
    <xsl:attribute name="hyphenation-character">\</xsl:attribute>
  </xsl:attribute-set>
  
  <!--==============================================-->
  <!--               Links                          -->
  <!--==============================================-->

  <xsl:template match="link">
    <fo:basic-link internal-destination="{@linkend}"
                   xsl:use-attribute-sets="xref.properties"
                   text-decoration="underline"
                   color="blue">
      <xsl:choose>
        <xsl:when test="count(child::node())=0">
          <xsl:value-of select="@linkend"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
    </fo:basic-link>
  </xsl:template>

  <!-- Links are printed in footnotes (not just after the link's text) -->
  <xsl:param name="ulink.footnotes" select="1"/>

  <xsl:template match="*" mode="simple.xlink.properties">
  <!-- Placeholder template to apply properties to links made from
       elements other than xref, link, and olink.
       This template should generate attributes only, as it is
       applied right after the opening <fo:basic-link> tag.
       -->
  <xsl:attribute name="color">#576c74</xsl:attribute>
  <xsl:attribute name="text-decoration">underline</xsl:attribute>
  <!-- Since this is a mode, you can create different
       templates with different properties for different linking elements -->
</xsl:template>


</xsl:stylesheet>


