<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xslthl="http://xslthl.sf.net"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="xslthl"
                version='1.0'>

  <xsl:import href="urn:docbkx:stylesheet"/>

  <!--==============================================-->
  <!--                HTML Settings                 -->
  <!--==============================================-->

  <!-- These extensions are required for table printing and other stuff -->
  <xsl:param name="tablecolumns.extension">0</xsl:param>
  <xsl:param name="graphicsize.extension">0</xsl:param>
  <xsl:param name="ignore.image.scaling">1</xsl:param>

  <!--  use graphics in admonitions -->
  <xsl:param name="admon.graphics" select="1"/>
  <xsl:param name="admon.graphics.path">images/admons/</xsl:param>
  <xsl:param name="admon.graphics.extension">.png</xsl:param>

  <xsl:param name="callout.graphics.path" select="'images/callouts/'"/>
  <!--  chapters will be numbered -->
  <xsl:param name="chapter.autolabel" select="1"/>

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
  <xsl:param name="section.autolabel" select="1"/>
  <!--  section numbers will include the chapter number -->
  <xsl:param name="section.label.includes.component.label" select="1"/>
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
	<!-- Do not write ToC automatically -->
  </xsl:param>

 <xsl:template match="db:programlisting[@language]|db:screen[@language]" mode="class.value">
    <xsl:param name="class" select="local-name(.)"/>
    <xsl:variable name="lang" select="concat('lang-', @language, ' ')"/>
    <!-- Line numbering enable by default -->
    <xsl:value-of select="concat('prettyprint ', $lang, 'linenums ', $class)"/>
<!--     <xsl:choose> -->
<!--       <xsl:when test="@linenumbering = 'linenums'"> -->
<!--         <xsl:value-of select="concat('prettyprint ', $lang, 'linenums ', $class)"/> -->
<!--       </xsl:when> -->
<!--       <xsl:otherwise> -->
<!--         <xsl:value-of select="concat('prettyprint ', $lang, $class)"/> -->
<!--       </xsl:otherwise> -->
<!--     </xsl:choose> -->
  </xsl:template>
  
  <!--==============================================-->
  <!--             Headers and Footers			  	-->
  <!--==============================================-->
  
  <xsl:template name="user.header.content">
      <!-- Navbar
    ================================================== -->
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container">
          <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="brand" href="#"><img src="images/community-documentation.png" style="border:none;height:24px"/></a>
          <div class="nav-collapse collapse">
		  	<ul class="nav">
			   <li class="active">
					<a class="brand" href="http://www.peergreen.com/" title="Peergreen"><img alt="Peergreen logo" src="images/peergreen-logo-white.png" /></a>
			   </li>
			   <li class="">
                	<a href="./getting-started-guide.xhtml">Getting started</a>
               </li>
               <li class="">
                	<a href="./user-guide.xhtml">User guide</a>
               </li>
               <li class="dropdown">
		          <a id="drop1" href="#" role="button" class="dropdown-toggle" data-toggle="dropdown">Tutorials<b class="caret"></b></a>
		          <ul class="dropdown-menu" role="menu" aria-labelledby="drop1">
		            <li><a href="./peergreen-platform-osgi-arquillian-junit-guide.xhtml">Testing OSGi applications with Arquillian, maven &amp; JUnit</a></li>
		            <li><a href="./peergreen-platform-osgi-paxexam-junit-guide.xhtml">Testing OSGi applications with pax-exam 3, maven &amp; JUnit</a></li>
		            <li><a href="./peergreen-platform-osgi-paxexam-testng-guide.xhtml">Testing OSGi applications with pax-exam 3, maven &amp; TestNG</a></li>
		          </ul>
		        </li>
			</ul>
          </div>
        </div>
      </div>
    </div> 
    
    <header class="jumbotron subhead" id="overview">
    	<div class="container">
		<div class="lead">
				<h1 class="title"><xsl:value-of select="db:info/db:title"/></h1>
				<p>
				<xsl:if test="db:info/db:authorgroup/db:author != ''">
					Written by
						<xsl:for-each select="db:info/db:authorgroup/db:author">
		                  <xsl:if test="position() &gt; 1">
		                    <xsl:text>, </xsl:text>
		                  </xsl:if>
		                  <xsl:value-of select="db:personname"/>
						</xsl:for-each>
		            	<br />
	            </xsl:if>
	            <xsl:if test="db:info/db:releaseinfo != ''">
					Version : <xsl:value-of select="db:info/db:releaseinfo"/>
	            </xsl:if>
	            </p>
			</div>
	   	</div>
	</header>
  </xsl:template>

  <xsl:template name="user.footer.content">
    <script src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script src="js/prettify.js"/>
    <script src="js/bootstrap.js"></script>
	<script src="js/application.js"></script>
    <script>prettyPrint();</script>
	<!-- Fluid transition -->
	<script>
		$('a[href^="#"]').click(function(){
			var the_id = $(this).attr("href");
			$('html, body').animate({
				scrollTop:$(the_id).offset().top
			}, 'slow');
			return false;
		});
	</script>

	<!-- Footer -->
	<div class="footer" >
		<div class='container content'>
			<div class="row">
				<div class="span12 pagination-centered">			
					<div class="inner clearfix">
						<div class="content clearfix">
							<div>Copyright &#169; Peergreen 2013 All rights reserved.</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

  </xsl:template>
  
  <!--==============================================-->
  <!--             HTML Customization			  	-->
  <!--==============================================-->

  <xsl:template name="book.titlepage.recto">
	<!-- No default title page -->
  </xsl:template>
  
  <xsl:template name="chapter.titlepage.recto">
	<div class="page-header">
		<xsl:attribute name="id">
			<xsl:call-template name="object.id">
			<xsl:with-param name="object" select="."/>
		</xsl:call-template>
		</xsl:attribute>
		<h1>
			<xsl:apply-templates select="." mode="object.title.markup"/>
		</h1>
	</div>
  </xsl:template>

  <xsl:template name="section.titlepage.recto">
	<div class="section-title">
		<xsl:attribute name="id">
			<xsl:call-template name="object.id">
			<xsl:with-param name="object" select="."/>
		</xsl:call-template>
		</xsl:attribute>
		<h2>
			<xsl:apply-templates select="." mode="object.title.markup"/>
		</h2>
	</div>
  </xsl:template>

  <xsl:template name="body.attributes">
  	<xsl:attribute name="data-spy">scroll</xsl:attribute>
  	<xsl:attribute name="data-target">.bs-docs-sidebar</xsl:attribute>
  </xsl:template>
  
  <!-- ToC Customization -->
  <xsl:include href="toc.xsl"/>
  <xsl:param name="toc.list.type">ul</xsl:param>
  <xsl:template name="toc.list.attributes">
	<xsl:attribute name="class">nav nav-list bs-docs-sidenav</xsl:attribute>
  </xsl:template>

  <!-- Body Customization -->
  <xsl:include href="body.xsl"/>

</xsl:stylesheet>
