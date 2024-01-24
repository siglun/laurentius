<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	       version="1.0" >

  <xsl:output method="xml"
	      encoding="UTf-8"/>


  <xsl:template match="/">
    <terms>

      <xsl:for-each select="//author">
	<xsl:call-template name="term_entry">
	  <xsl:with-param name="term_type" select="'author'"/>
	</xsl:call-template>
      </xsl:for-each>

      <xsl:for-each select="//title">
	<xsl:call-template name="term_entry">
	  <xsl:with-param name="term_type" select="'title'"/>
	</xsl:call-template>
      </xsl:for-each>

      <xsl:for-each select="//origPlace">
	<xsl:call-template name="term_entry">
	  <xsl:with-param name="term_type" select="'publ-place'"/>
	</xsl:call-template>
      </xsl:for-each>

      <xsl:for-each select="//origDate">
	<xsl:call-template name="term_entry">
	  <xsl:with-param name="term_type" select="'publ-date'"/>
	</xsl:call-template>
      </xsl:for-each>

      <xsl:for-each select="//textLang">
	<xsl:call-template name="term_entry">
	  <xsl:with-param name="term_type" select="'text-language'"/>
	</xsl:call-template>
      </xsl:for-each>

      <xsl:for-each select="//name[@type='person']">
	<xsl:call-template name="term_entry">
	  <xsl:with-param name="term_type" select="'person'"/>
	</xsl:call-template>
      </xsl:for-each>

      <xsl:for-each select="//name[@type='place']">
	<xsl:call-template name="term_entry">
	  <xsl:with-param name="term_type" select="'place'"/>
	</xsl:call-template>
      </xsl:for-each>

      <xsl:for-each 
	  select="//name[not(@type='place' or @type='person')]">
	<xsl:call-template name="term_entry">
	  <xsl:with-param name="term_type" select="'other'"/>
	</xsl:call-template>
      </xsl:for-each>
    </terms>
  </xsl:template>

  <xsl:template name="term_entry">
    <xsl:param name="term_type" select="'title'"/>
    <xsl:element name="term">
      <xsl:attribute name="reference">
	<xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:attribute name="type">
	<xsl:value-of select="$term_type"/>
      </xsl:attribute>
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:element>
  </xsl:template>

</xsl:transform>