<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	       xmlns:exsl="http://exslt.org/common"
	       extension-element-prefixes="exsl"
	       version="1.0">

  <xsl:param name="fileid" select="/msDescription/@id"/>

  <xsl:output
      method="xml"
      encoding="UTF-8"/>

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="msDescription">
    <xsl:element name="msDescription">
       <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="node()">
   <xsl:variable name="element" select="name(.)" />
   <xsl:if test="$element">
     <xsl:element name="{$element}">
       <xsl:if test="not(@id)">
	 <xsl:attribute name="id">
	   <xsl:value-of select="concat($fileid,':',generate-id(.))"/>
	 </xsl:attribute>
       </xsl:if>
       <xsl:apply-templates select="@*|node()"/>
     </xsl:element>
   </xsl:if>
 </xsl:template>

 <xsl:template match="@*">
   <xsl:variable name="attribute" select="name(.)"/>
   <xsl:attribute name="{$attribute}">
     <xsl:value-of select="."/>
   </xsl:attribute>
 </xsl:template>

 <xsl:template match="text()">
   <xsl:copy>
     <xsl:value-of select="."/>
   </xsl:copy>
 </xsl:template>
  
</xsl:transform>
