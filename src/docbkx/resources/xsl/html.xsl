<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xslthl="http://xslthl.sf.net"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns="http://www.w3.org/1999/xhtml"
                exclude-result-prefixes="xslthl db"
                version='1.0'>

  <xsl:import href="urn:docbkx:stylesheet"/>

  <!--==============================================-->
  <!--                HTML Settings                 -->
  <!--==============================================-->

  <!-- These extensions are required for table printing and other stuff -->
  <xsl:param name="tablecolumns.extension">0</xsl:param>
  <xsl:param name="graphicsize.extension">0</xsl:param>
  <xsl:param name="ignore.image.scaling">0</xsl:param>

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
  <xsl:param name="toc.section.depth">0</xsl:param>
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
  <xsl:template name="user.head.content">
  	<link href='http://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'/>
  	<link rel="shortcut icon" type="image/x-icon" href="images/favicon.ico" />
  	<!-- Google Analytics -->
  	<script type="text/javascript">
		var _gaq = _gaq || [];
		_gaq.push(['_setAccount', 'UA-34638166-1']);
		_gaq.push(['_setDomainName', 'peergreen.com']);
		_gaq.push(['_setAllowLinker', true]);
		_gaq.push(['_trackPageview']);
		
		(function() {
		var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
		ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
		var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
		})();
	</script>
  </xsl:template>
  
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
          <a class="brand" href="http://docs.peergreen.com"><img src="images/community-documentation.png" style="border:none;height:24px"/></a>
          <div class="nav-collapse collapse">
		  	<ul class="nav">
			   <li class="">
					<a class="brand" target="_blank" href="http://www.peergreen.com/" title="Peergreen"><img alt="Peergreen logo" src="images/peergreen-logo-white.png" /></a>
			   </li>
			    <xsl:variable name="current-name">
			    	<xsl:call-template name="getFileNameByID">
            			<xsl:with-param name="book-id">
            				<xsl:value-of select="@xml:id"/>	
            			</xsl:with-param>
            		</xsl:call-template>	
			    </xsl:variable>
			   	<xsl:for-each select="document('../../peergreen-server-documentation.xml')/files/file">
			   		<li>
			   			<xsl:attribute name="class">
			   				<xsl:choose>
					   			<xsl:when test="$current-name=./name">
					   				<xsl:text>active</xsl:text>
					   			</xsl:when>
					   		</xsl:choose>
			   			</xsl:attribute>
			   		
			   			<a>
			   				<xsl:attribute name="href">
			   					<xsl:value-of select="substring-before(./name,'.')"/>
			   					<xsl:text>.xhtml</xsl:text>	
			   				</xsl:attribute>
		  					<xsl:value-of select="./label"/>
		  				</a>
		  			</li>
		  		</xsl:for-each>
		  		<xsl:for-each select="document('../../peergreen-server-documentation.xml')/files/set">
		  			<li class="dropdown">
		  				<a id="drop1" href="#" role="button" class="dropdown-toggle" 
		  				   data-toggle="dropdown"><xsl:value-of select="@label"/><b class="caret"></b></a>
		  				<ul class="dropdown-menu" role="menu" aria-labelledby="drop1">
		  					<xsl:for-each select="./file">
						   		<li>
						   			<xsl:attribute name="class">
						   				<xsl:choose>
								   			<xsl:when test="$current-name=./name">
								   				<xsl:text>active</xsl:text>
								   			</xsl:when>
								   		</xsl:choose>
						   			</xsl:attribute>
						   			<a>
						   				<xsl:attribute name="href">
						   					<xsl:value-of select="substring-before(./name,'.')"/>
						   					<xsl:text>.xhtml</xsl:text>	
						   				</xsl:attribute>
					  					<xsl:value-of select="./label"/>
					  				</a>
					  			</li>
					  		</xsl:for-each>
		  				</ul>
		  			</li>	
		  		</xsl:for-each>
			</ul>
          </div>
        </div>
      </div>
    </div> 
    
    <header class="jumbotron subhead" id="overview">
    	<div class="container">
			<div class="row">
				<div class="span12">
					<h1 class="title"><xsl:value-of select="db:info/db:title"/></h1>
				</div>
				<div class="span4">
		    		<a class="btn btn-primary btn-large">
		            	<xsl:attribute name="href">
		            		<xsl:variable name="name">
			            		<xsl:call-template name="getFileNameByID">
			            			<xsl:with-param name="book-id">
			            				<xsl:value-of select="@xml:id"/>	
			            			</xsl:with-param>
			            		</xsl:call-template>
		            		</xsl:variable>	    
		            		
		            		<xsl:text>../pdf/</xsl:text> 
		            		<xsl:value-of select="substring-before($name,'.')"/>
		            		<xsl:text>.pdf</xsl:text>       		
		            	</xsl:attribute>
		            	<img src="images/pdf.png" alt="PDF" width="24px"/> 
		             	Download the PDF version
		            </a>
		    	</div>
				<div class="span8">
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
						<br />
		            </xsl:if>
		            <xsl:if test="db:info/db:date != ''">
						Latest update : <xsl:value-of select="db:info/db:date"/>
						<br />
		            </xsl:if>
		            </p>
		    	</div>
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
	<script src="http://apis.google.com/js/plusone.js"></script>
	<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="https://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>
	<div id="fb-root"></div>
	<script>
		(function(d, s, id) {
		  var js, fjs = d.getElementsByTagName(s)[0];
		  if (d.getElementById(id)) return;
		  js = d.createElement(s); js.id = id;
		  js.src = "//connect.facebook.net/en_GB/all.js#xfbml=1&amp;appId=258770354165193";
		  fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
	</script>
	
	<!-- Footer -->
	<div class="footer" >
		<div class='container content'>
			<div class="row">
				<div class="span4"></div>
				<div class="span4 pagination-centered">			
					<div class="inner clearfix">
						<div class="content clearfix">
							<div>Copyright &#169; Peergreen 2013 All rights reserved.</div>
						</div>
						<br />
						<div>
							<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/3.0/deed.fr">
							<img alt="Licence Creative Commons" style="border-width:0" src="http://i.creativecommons.org/l/by-nc-nd/3.0/88x31.png" />
							</a>
							<br />
							<span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">
							<a xmlns:cc="http://creativecommons.org/ns#" href="http://www.peergreen.com" property="cc:attributionName" rel="cc:attributionURL">
							Peergreen</a> documentation</span> is available under the terms of 
							<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/3.0/deed.fr">
							the Creative Commons Attribution - Non commercial - No Derivative Works 3.0 not transposed.</a>.
						</div>
					</div>
				</div>
				<div class="span4"></div>
			</div>
		</div>
	</div>
  </xsl:template>
  
  <xsl:template name="getFileNameByID">
  	<xsl:param name="book-id"/>
  	<xsl:for-each select="document('../../peergreen-server-documentation.xml')/files/file">
  		<xsl:if test="@id=$book-id">
  			<xsl:value-of select="./name"/>
  		</xsl:if>
  	</xsl:for-each>
  	<xsl:for-each select="document('../../peergreen-server-documentation.xml')/files/set">
  		<xsl:for-each select="./file">
  			<xsl:if test="@id=$book-id">
	  			<xsl:value-of select="./name"/>
	  		</xsl:if>
  		</xsl:for-each>
  	</xsl:for-each>
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

  <!--<xsl:template name="section.titlepage.recto">
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
  </xsl:template>     -->

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
