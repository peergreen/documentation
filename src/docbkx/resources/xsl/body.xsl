<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:d="http://docbook.org/ns/docbook"
                version='1.0'>
                
	<xsl:template match="*" mode="process.root">
	  <xsl:variable name="doc" select="self::*"/>
	
	  <xsl:call-template name="user.preroot"/>
	  <xsl:call-template name="root.messages"/>
	
	  <html xmlns="http://www.w3.org/1999/xhtml">
	    <xsl:call-template name="root.attributes"/>
	    <head>
	      <xsl:call-template name="system.head.content">
	        <xsl:with-param name="node" select="$doc"/>
	      </xsl:call-template>
	      <xsl:call-template name="head.content">
	        <xsl:with-param name="node" select="$doc"/>
	      </xsl:call-template>
	      <xsl:call-template name="user.head.content">
	        <xsl:with-param name="node" select="$doc"/>
	      </xsl:call-template>
	    </head>
	    <body>
	      <xsl:call-template name="body.attributes"/>
	      <xsl:call-template name="user.header.content">
	        <xsl:with-param name="node" select="$doc"/>
	      </xsl:call-template>
	      <div class="container">
	      	<div class="row">
	      		<div class="span3">
	      			<!-- Insert ToC -->
	      			<xsl:call-template name="division.toc">
						<xsl:with-param name="toc-context" select="d:book"/>
						<xsl:with-param name="toc.title.p" select="false()"></xsl:with-param>
					    <xsl:with-param name="nodes" select="EMPTY"/>
				  	</xsl:call-template>
	      		</div>
	      		<div class="span9">
	      			<!-- Insert HTML content -->
	      			<xsl:apply-templates select="."/>
	      		</div>
	      	</div>
	      </div>
	      <xsl:call-template name="user.footer.content">
	        <xsl:with-param name="node" select="$doc"/>
	      </xsl:call-template>
	    </body>
	  </html>
	  <xsl:value-of select="$html.append"/>
	  
	  <!-- Generate any css files only once, not once per chunk -->
	  <xsl:call-template name="generate.css.files"/>
	</xsl:template>

</xsl:stylesheet> 