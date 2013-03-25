<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:d="http://docbook.org/ns/docbook"
                version='1.0'>
                
	<xsl:template name="make.toc">
	  <xsl:param name="toc-context" select="."/>
	  <xsl:param name="toc.title.p" select="true()"/>
	  <xsl:param name="nodes" select="/NOT-AN-ELEMENT"/>
	
	  <xsl:variable name="nodes.plus" select="$nodes | qandaset"/>
	
	  <xsl:variable name="toc.title">
	    <xsl:if test="$toc.title.p">
	      <xsl:choose>
	        <xsl:when test="$make.clean.html != 0">
	          <div class="toc-title">
	            <xsl:call-template name="gentext">
	              <xsl:with-param name="key">TableofContents</xsl:with-param>
	            </xsl:call-template>
	          </div>
	        </xsl:when>
	        <xsl:otherwise>
	          <p>
	            <b>
	              <xsl:call-template name="gentext">
	                <xsl:with-param name="key">TableofContents</xsl:with-param>
	              </xsl:call-template>
	            </b>
	          </p>
	        </xsl:otherwise>
	      </xsl:choose>
	    </xsl:if>
	  </xsl:variable>
	
	  <xsl:choose>
	    <xsl:when test="$manual.toc != ''">
	      <xsl:variable name="id">
	        <xsl:call-template name="object.id"/>
	      </xsl:variable>
	      <xsl:variable name="toc" select="document($manual.toc, .)"/>
	      <xsl:variable name="tocentry" select="$toc//tocentry[@linkend=$id]"/>
	      <xsl:if test="$tocentry and $tocentry/*">
	        <div class="span3 bs-docs-sidebar" xmlns="http://www.w3.org/1999/xhtml">
	          <xsl:copy-of select="$toc.title"/>
	          <xsl:element name="{$toc.list.type}">
	            <xsl:call-template name="toc.list.attributes">
	              <xsl:with-param name="toc-context" select="$toc-context"/>
	              <xsl:with-param name="toc.title.p" select="$toc.title.p"/>
	              <xsl:with-param name="nodes" select="$nodes"/>
	            </xsl:call-template>
	            <xsl:call-template name="manual-toc">
	              <xsl:with-param name="tocentry" select="$tocentry/*[1]"/>
	            </xsl:call-template>
	          </xsl:element>
	        </div>
	      </xsl:if>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:choose>
	        <xsl:when test="$qanda.in.toc != 0">
	          <xsl:if test="$nodes.plus">
	            <div class="span3 bs-docs-sidebar" xmlns="http://www.w3.org/1999/xhtml">
	              <xsl:copy-of select="$toc.title"/>
	              <xsl:element name="{$toc.list.type}">
	                <xsl:call-template name="toc.list.attributes">
	                  <xsl:with-param name="toc-context" select="$toc-context"/>
	                  <xsl:with-param name="toc.title.p" select="$toc.title.p"/>
	                  <xsl:with-param name="nodes" select="$nodes"/>
	                </xsl:call-template>
	                <xsl:apply-templates select="$nodes.plus" mode="toc">
	                  <xsl:with-param name="toc-context" select="$toc-context"/>
	                </xsl:apply-templates>
	              </xsl:element>
	            </div>
	          </xsl:if>
	        </xsl:when>
	        <xsl:otherwise>
	          <xsl:if test="$nodes">
	            <div class="span3 bs-docs-sidebar" xmlns="http://www.w3.org/1999/xhtml">
	              <xsl:copy-of select="$toc.title"/>
	              <xsl:element name="{$toc.list.type}">
	                <xsl:call-template name="toc.list.attributes">
	                  <xsl:with-param name="toc-context" select="$toc-context"/>
	                  <xsl:with-param name="toc.title.p" select="$toc.title.p"/>
	                  <xsl:with-param name="nodes" select="$nodes"/>
	                </xsl:call-template>
	                <xsl:apply-templates select="$nodes" mode="toc">
	                  <xsl:with-param name="toc-context" select="$toc-context"/>
	                </xsl:apply-templates>
	              </xsl:element>
	            </div>
	          </xsl:if>
	        </xsl:otherwise>
	      </xsl:choose>
	
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:template>
	
	<xsl:template name="toc.line">
	  <xsl:param name="toc-context" select="."/>
	  <xsl:param name="depth" select="1"/>
	  <xsl:param name="depth.from.context" select="8"/>
	
	  <!-- * if $autotoc.label.in.hyperlink is zero, then output the label -->
	  <!-- * before the hyperlinked title (as the DSSSL stylesheet does) -->
	  <xsl:if test="$autotoc.label.in.hyperlink = 0">
	    <xsl:variable name="label">
	      <xsl:apply-templates select="." mode="label.markup"/>
	    </xsl:variable>
	    <xsl:copy-of select="$label"/>
	    <xsl:if test="$label != ''">
	      <xsl:value-of select="$autotoc.label.separator"/>
	    </xsl:if>
	  </xsl:if>
	
	  <a xmlns="http://www.w3.org/1999/xhtml">
	    <xsl:attribute name="href">
	      <xsl:call-template name="href.target">
	        <xsl:with-param name="context" select="$toc-context"/>
	        <xsl:with-param name="toc-context" select="$toc-context"/>
	      </xsl:call-template>
	    </xsl:attribute>
	    
	    
	  <!-- * if $autotoc.label.in.hyperlink is non-zero, then output the label -->
	  <!-- * as part of the hyperlinked title -->
	  <xsl:if test="not($autotoc.label.in.hyperlink = 0)">
	    <xsl:variable name="label">
	      <xsl:apply-templates select="." mode="label.markup"/>
	    </xsl:variable>
	    <xsl:copy-of select="$label"/>
	    <xsl:if test="$label != ''">
	      <xsl:value-of select="$autotoc.label.separator"/>
	    </xsl:if>
	  </xsl:if>
	
	    <xsl:apply-templates select="." mode="titleabbrev.markup"/>
	  </a>
	</xsl:template>
	
	<xsl:variable name="toc.listitem.type">
	  <xsl:choose>
	    <xsl:when test="$toc.list.type = 'dl'">dt</xsl:when>
	    <xsl:otherwise>li</xsl:otherwise>
	  </xsl:choose>
	</xsl:variable>
	
	<!-- this is just hack because dl and ul aren't completely isomorphic -->
	<xsl:variable name="toc.dd.type">
	  <xsl:choose>
	    <xsl:when test="$toc.list.type = 'dl'">dd</xsl:when>
	    <xsl:otherwise/>
	  </xsl:choose>
	</xsl:variable>

	<xsl:template name="subtoc">
	  <xsl:param name="toc-context" select="."/>
	  <xsl:param name="nodes" select="NOT-AN-ELEMENT"/>
	
	  <xsl:variable name="nodes.plus" select="$nodes | d:qandaset"/>
	
	  <xsl:variable name="subtoc">
	    <xsl:element name="{$toc.list.type}" namespace="http://www.w3.org/1999/xhtml">
	      <xsl:choose>
	        <xsl:when test="$qanda.in.toc != 0">
	          <xsl:apply-templates mode="toc" select="$nodes.plus">
	            <xsl:with-param name="toc-context" select="$toc-context"/>
	          </xsl:apply-templates>
	        </xsl:when>
	        <xsl:otherwise>
	          <xsl:apply-templates mode="toc" select="$nodes">
	            <xsl:with-param name="toc-context" select="$toc-context"/>
	          </xsl:apply-templates>
	        </xsl:otherwise>
	      </xsl:choose>
	    </xsl:element>
	  </xsl:variable>
	
	  <xsl:variable name="depth">
	    <xsl:choose>
	      <xsl:when test="local-name(.) = 'section'">
	        <xsl:value-of select="count(ancestor::d:section) + 1"/>
	      </xsl:when>
	      <xsl:when test="local-name(.) = 'sect1'">1</xsl:when>
	      <xsl:when test="local-name(.) = 'sect2'">2</xsl:when>
	      <xsl:when test="local-name(.) = 'sect3'">3</xsl:when>
	      <xsl:when test="local-name(.) = 'sect4'">4</xsl:when>
	      <xsl:when test="local-name(.) = 'sect5'">5</xsl:when>
	      <xsl:when test="local-name(.) = 'refsect1'">1</xsl:when>
	      <xsl:when test="local-name(.) = 'refsect2'">2</xsl:when>
	      <xsl:when test="local-name(.) = 'refsect3'">3</xsl:when>
	      <xsl:when test="local-name(.) = 'topic'">1</xsl:when>
	      <xsl:when test="local-name(.) = 'simplesect'">
	        <!-- sigh... -->
	        <xsl:choose>
	          <xsl:when test="local-name(..) = 'section'">
	            <xsl:value-of select="count(ancestor::d:section)"/>
	          </xsl:when>
	          <xsl:when test="local-name(..) = 'sect1'">2</xsl:when>
	          <xsl:when test="local-name(..) = 'sect2'">3</xsl:when>
	          <xsl:when test="local-name(..) = 'sect3'">4</xsl:when>
	          <xsl:when test="local-name(..) = 'sect4'">5</xsl:when>
	          <xsl:when test="local-name(..) = 'sect5'">6</xsl:when>
	          <xsl:when test="local-name(..) = 'topic'">2</xsl:when>
	          <xsl:when test="local-name(..) = 'refsect1'">2</xsl:when>
	          <xsl:when test="local-name(..) = 'refsect2'">3</xsl:when>
	          <xsl:when test="local-name(..) = 'refsect3'">4</xsl:when>
	          <xsl:otherwise>1</xsl:otherwise>
	        </xsl:choose>
	      </xsl:when>
	      <xsl:otherwise>0</xsl:otherwise>
	    </xsl:choose>
	  </xsl:variable>
	
	  <xsl:variable name="depth.from.context" select="count(ancestor::*)-count($toc-context/ancestor::*)"/>
	
	  <xsl:variable name="subtoc.list">
	    <xsl:choose>
	      <xsl:when test="$toc.dd.type = ''">
	        <xsl:copy-of select="$subtoc"/>
	      </xsl:when>
	      <xsl:otherwise>
	        <xsl:element name="{$toc.dd.type}" namespace="http://www.w3.org/1999/xhtml">
	          <xsl:copy-of select="$subtoc"/>
	        </xsl:element>
	      </xsl:otherwise>
	    </xsl:choose>
	  </xsl:variable>
	
	  <xsl:element name="{$toc.listitem.type}" namespace="http://www.w3.org/1999/xhtml">
	    <xsl:call-template name="toc.line">
	      <xsl:with-param name="toc-context" select="$toc-context"/>
	    </xsl:call-template>
	    <xsl:if test="$toc.listitem.type = 'li' and                   
	    				( (self::d:set or self::d:book or self::d:part) or                          
	    				$toc.section.depth &gt; $depth) and                    
	    				( ($qanda.in.toc = 0 and count($nodes)&gt;0) or                     
	    				($qanda.in.toc != 0 and count($nodes.plus)&gt;0) )                  
	    				and $toc.max.depth &gt; $depth.from.context">
	      <xsl:copy-of select="$subtoc.list"/>
	    </xsl:if>
	  </xsl:element>
	  <xsl:if test="$toc.listitem.type != 'li' and                   
	  				( (self::d:set or self::d:book or self::d:part) or                          
	  				$toc.section.depth &gt; $depth) and                  
	  				( ($qanda.in.toc = 0 and count($nodes)&gt;0) or                   
	  				($qanda.in.toc != 0 and count($nodes.plus)&gt;0) )                 
	  				and $toc.max.depth &gt; $depth.from.context">
	    <xsl:copy-of select="$subtoc.list"/>
	  </xsl:if>
	</xsl:template>

</xsl:stylesheet>