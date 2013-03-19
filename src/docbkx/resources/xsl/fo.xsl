<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:db="http://docbook.org/ns/docbook"
                exclude-result-prefixes="db"
                version='1.0'>

  <xsl:import href="urn:docbkx:stylesheet"/>
  <xsl:import href="highlight-fo.xsl"/>

  <!--==============================================-->
  <!--             Custom Title Page                -->
  <!--==============================================-->

  <xsl:template name="book.titlepage.recto">
    <fo:block>
      <fo:table table-layout="fixed" width="175mm">
        <fo:table-column column-width="175mm" />
        <fo:table-body>
          <fo:table-row height="30mm">
            <fo:table-cell text-align="center" display-align="before">
              <fo:block>
                <fo:external-graphic>
                  <xsl:attribute name="src">
                    <xsl:value-of select="$img.src.path" />
                    <xsl:text>images/pg_banner.png</xsl:text>
                  </xsl:attribute>
                </fo:external-graphic>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
          <fo:table-row height="120mm">
            <fo:table-cell text-align="center" display-align="center">
              <fo:block font-family="Helvetica" font-size="32pt" padding-before="10mm">
                <xsl:value-of select="db:info/db:title" />
              </fo:block>
              <fo:block font-family="Helvetica" font-size="12pt" font-style="italic" padding="10mm">
                <xsl:value-of select="db:info/db:abstract" />
              </fo:block>
              <fo:block font-family="Helvetica" font-size="12pt" padding="10mm">
                <xsl:value-of select="db:info/db:releaseinfo" />
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
          <fo:table-row height="40mm">
            <fo:table-cell text-align="center" display-align="after">
              <fo:block font-family="Helvetica" font-size="10pt">
                <xsl:value-of select="db:info/db:authorgroup/db:author/db:orgname" />
                <xsl:text> (</xsl:text>
                <xsl:for-each select="db:info/db:authorgroup/db:author">
                  <!-- > 2 because we do not print the group author -->
                  <xsl:if test="position() &gt; 2">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                  <xsl:value-of select="db:personname" />
                </xsl:for-each>
                <xsl:text>)</xsl:text>
              </fo:block>

              <fo:block font-family="Helvetica" font-size="8pt" padding="2mm">
                <xsl:text>- </xsl:text>
                <xsl:value-of select="db:info/db:date" />
                <xsl:text> -</xsl:text>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
          <fo:table-row height="30mm">
            <fo:table-cell text-align="center" display-align="after">
              <fo:block font-family="Helvetica" font-size="12pt" padding="10mm">
                <xsl:text>Copyright &#169; </xsl:text>
                <xsl:value-of select="db:info/db:copyright/db:holder" />
                <xsl:text> </xsl:text>
                <xsl:value-of select="db:info/db:copyright/db:year" />
              </fo:block>
              <fo:block font-family="Helvetica" font-size="10pt" padding="1mm">
                <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode"
                                     select="db:info/db:legalnotice" />
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
  <xsl:param name="fop.extension">1</xsl:param>
  <xsl:param name="ignore.image.scaling">1</xsl:param>
  <!-- for getting bookmarks in pdf document -->
  <xsl:param name="fop1.extensions" select="1" />
  
  <!-- Body font -->
  <xsl:param name="body.font.family">Helvetica</xsl:param>
	
  <!--==============================================-->
  <!--        		Table of Contents				-->	
  <!--==============================================-->

    <xsl:param name="generate.toc">
        book      toc,title
    </xsl:param>
    
  <!--==============================================-->
  <!--    	  			Header						-->
  <!--==============================================-->

  <!-- More space in the center header for long text -->
  <xsl:attribute-set name="header.content.properties">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$body.font.family" />
    </xsl:attribute>
  </xsl:attribute-set>
  
  <!--==============================================-->
  <!--    	  		Custom Header					-->
  <!--==============================================-->

    <xsl:template name="header.content">	
        <xsl:param name="pageclass" select="''"/>
        <xsl:param name="sequence" select="''"/>
        <xsl:param name="position" select="''"/>
        <xsl:param name="gentext-key" select="''"/>
		
		<xsl:choose>
			<xsl:when test="$position='left'">
				<fo:external-graphic>
				  <xsl:attribute name="src">
					<xsl:value-of select="$img.src.path" />
					<xsl:text>images/logo-peergreen.png</xsl:text>
				  </xsl:attribute>
				  <xsl:attribute name="height">
					<xsl:text>20px</xsl:text>
				  </xsl:attribute>
				  <xsl:attribute name="width">
					<xsl:text>80px</xsl:text>
				  </xsl:attribute>
				  <xsl:attribute name="content-height">
					<xsl:text>scale-to-fit</xsl:text>
				  </xsl:attribute>
				  <xsl:attribute name="content-width">
					<xsl:text>scale-to-fit</xsl:text>
				  </xsl:attribute>
				</fo:external-graphic>
			</xsl:when>
			<xsl:when test="$position='right'">
				<!-- Insert chapter title -->
				<xsl:apply-templates select="." mode="object.title.markup"/>
			</xsl:when>
		</xsl:choose>
    </xsl:template>


  <!--==============================================-->
  <!--               Custom Footer                  -->
  <!--==============================================-->

  <!-- This footer prints the version number on the left side -->
  <xsl:template name="footer.content">
    <xsl:param name="pageclass" select="''" />
    <xsl:param name="sequence" select="''" />
    <xsl:param name="position" select="''" />
    <xsl:param name="gentext-key" select="''" />

    <xsl:variable name="info.version">
        <xsl:if test="//db:info/db:releaseinfo">
          <xsl:value-of select="//db:info/db:productname" />
		  <xsl:text> (</xsl:text>
          <xsl:value-of select="//db:info/db:releaseinfo" />
          <xsl:text>)</xsl:text>
        </xsl:if>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$sequence='blank'">
        <xsl:if test="$position = 'center'">
          <xsl:value-of select="$info.version" />
        </xsl:if>
      </xsl:when>
      <!-- for double sided printing, print page numbers on alternating sides (of the page) -->
      <xsl:when test="$double.sided != 0">
        <xsl:choose>
          <xsl:when test="$sequence = 'even' and $position='left'">
            <fo:page-number />
          </xsl:when>
          <xsl:when test="$sequence = 'odd' and $position='right'">
            <fo:page-number />
          </xsl:when>
          <xsl:when test="$position = 'center'">
            <xsl:value-of select="$info.version" />
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <!-- for single sided printing, print all page numbers on the right (of the page) -->
      <xsl:when test="$double.sided = 0">
        <xsl:choose>
          <xsl:when test="$position = 'center'">
            <xsl:value-of select="$info.version" />
          </xsl:when>
          <xsl:when test="$position = 'right'">
            <fo:page-number />
          </xsl:when>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:param name="paper.type" select="'A4'" />
  <xsl:param name="double.sided">0</xsl:param>
  <xsl:param name="headers.on.blank.pages">0</xsl:param>
  <xsl:param name="footers.on.blank.pages">0</xsl:param>

  <!-- Space between paper border and content (chaotic stuff, don't touch) -->
  <xsl:param name="page.margin.top">10mm</xsl:param>
  <xsl:param name="page.margin.bottom">15mm</xsl:param>
  <xsl:param name="page.margin.outer">18mm</xsl:param>
  <xsl:param name="page.margin.inner">18mm</xsl:param>

  <xsl:param name="body.margin.top">10mm</xsl:param>
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
  <xsl:param name="admon.graphics" select="1" />
  <xsl:param name="admon.graphics.path"><xsl:value-of select="$img.src.path" />images/admons/</xsl:param>
  <xsl:param name="admon.graphics.extension" select="'.png'"/>
  <xsl:attribute-set name="graphical.admonition.properties">
    <xsl:attribute name="background-color">#E6FBE8</xsl:attribute>
  </xsl:attribute-set>	
  <xsl:template match="*" mode="admon.graphic.width">
  	<xsl:text>22pt</xsl:text>
  </xsl:template>
  
  <!--  Titles style -->
  <xsl:attribute-set name="component.title.properties">
   	<xsl:attribute name="color">#317947</xsl:attribute>
  </xsl:attribute-set>
  
  <xsl:attribute-set name="section.title.properties">
   	<xsl:attribute name="color">#317947</xsl:attribute>
  </xsl:attribute-set>
  
  <!-- Fix the value, otherwise an HTTP URL was provided by default -->
  <xsl:param name="draft.watermark.image"><xsl:value-of select="$img.src.path" />images/admons/draft.png</xsl:param>

  <!-- don't use graphics for callout -->
  <xsl:param name="callout.graphics" select="0" />
  <!-- depth to which recursive sections should appear in the TOC -->
  <xsl:param name="toc.section.depth">2</xsl:param>
  <!--  chapters will be numbered -->
  <xsl:param name="chapter.autolabel" select="1" />
  <!-- Remove "Chapter" from the Chapter titles... -->
  <!--  <xsl:param name="local.l10n.xml" select="document('')"/>
  <l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
   	<l:l10n language="en">
        <l:context name="title-numbered">
            <l:template name="chapter" text="%n.&#160;%t"/>
        	<l:template name="section" text="%n&#160;%t"/>
    	</l:context>
  	</l:l10n>
  </l:i18n>-->
  <!--  sections will be numbered -->
  <xsl:param name="section.autolabel" select="1" />
  <!--  section numbers will include the chapter number -->
  <xsl:param name="section.label.includes.component.label" select="1" />
  <!-- ProgramListing/Screen has a background color -->
  <xsl:param name="shade.verbatim">1</xsl:param>
  <xsl:attribute-set name="shade.verbatim.style">
    <xsl:attribute name="background-color">#edf8fd</xsl:attribute>
  </xsl:attribute-set>
  <!-- Reduce size of program listing font and add a border -->
  <xsl:attribute-set name="verbatim.properties">
    <xsl:attribute name="space-before.minimum">1em</xsl:attribute>
    <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
    <xsl:attribute name="space-before.maximum">1em</xsl:attribute>
    <xsl:attribute name="font-size">7pt</xsl:attribute>
    <xsl:attribute name="border-width">1px</xsl:attribute>
    <xsl:attribute name="border-style">dashed</xsl:attribute>
    <xsl:attribute name="border-color">#9999cc</xsl:attribute>
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
    <xsl:attribute name="wrap-option">wrap</xsl:attribute>
    <xsl:attribute name="hyphenation-character">\</xsl:attribute>
  </xsl:attribute-set>

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

</xsl:stylesheet>


