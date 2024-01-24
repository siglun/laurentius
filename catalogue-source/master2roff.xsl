<?xml version='1.0' encoding='iso-8859-1'?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY sp " ">
<!ENTITY nl "

">
<!ENTITY continue "
\&amp;">
]>
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
                xmlns='http://www.w3.org/1999/xhtml'
		version='1.0'>


<xsl:strip-space elements="*" />
<xsl:output encoding='UTF-8' method="text" />
<xsl:variable name="msid" select="/msDescription/@id" />

<xsl:template match="/">
<xsl:text>
.big
</xsl:text>
<xsl:apply-templates />
</xsl:template>

<xsl:template match="sourceDesc">
<xsl:apply-templates select="id($msid)" />
</xsl:template>

<xsl:template match="msDescription">
<xsl:if test="$msid != 'Mh_1'">.bp</xsl:if><xsl:text>
.sy perl -e '$id="</xsl:text><xsl:value-of select="$msid"/><xsl:text>";$id=~s/_/ /;print ".ds segment $id\\n";' > /tmp/x\n[$$]
.so /tmp/x\n[$$]
.tm Doing \*[segment]
.segm \*[segment]
.sy rm /tmp/x\n[$$]
.ds HS_START "here
</xsl:text><xsl:apply-templates />
</xsl:template>

<xsl:template match="msIdentifier">
<xsl:text>
.SH
.ft R
.ps +2
.vs +2
.above
.smallcaps
</xsl:text>
<xsl:apply-templates select="idno"/><xsl:if
      test="altName[@type='nickname']">;<xsl:text>
</xsl:text></xsl:if>
<xsl:apply-templates select="altName[@type='nickname']"/>
<xsl:text>
./smallcaps
.below
.LP
</xsl:text>
<xsl:choose>
<xsl:when test="institution"><xsl:text>
</xsl:text><xsl:value-of select="institution" /><xsl:text>
(in deposition at
</xsl:text>
<xsl:value-of select="repository"/>)
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="repository"/>
</xsl:otherwise></xsl:choose>
<xsl:if test="altName[@type='former shelfmark']"><xsl:text>
.br
Olim:
</xsl:text>
<xsl:for-each select="altName[@type='former shelfmark']">
<xsl:apply-templates/>
<xsl:if test="position() != last()">;</xsl:if><xsl:text>
</xsl:text>
</xsl:for-each>
</xsl:if>
</xsl:template>

<xsl:template match="msHeading">
<xsl:text>
.LP
</xsl:text>
<xsl:if test="author">
<xsl:apply-templates select="author" mode="hdr" /><xsl:text>
</xsl:text></xsl:if>
<xsl:for-each select="title">
<xsl:if test="@type='uniform'">\fI</xsl:if><xsl:apply-templates/><xsl:choose><xsl:when test="position()=last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>; </xsl:text></xsl:otherwise></xsl:choose><xsl:text>\fR</xsl:text>
</xsl:for-each><xsl:text>
</xsl:text><xsl:apply-templates select="origPlace" /><xsl:text>
</xsl:text><xsl:apply-templates select="origDate" /><xsl:text>
</xsl:text><xsl:apply-templates select="textLang" /><xsl:text>
</xsl:text><xsl:for-each select="note">
<xsl:text>
.LP
</xsl:text>
<xsl:apply-templates/>
<xsl:choose>
<xsl:when test="position()=last()">.</xsl:when>
<xsl:otherwise><xsl:apply-templates/>;</xsl:otherwise>
</xsl:choose>
</xsl:for-each>
</xsl:template>

<xsl:template match="author" mode="hdr">
<xsl:text>
.print-index-entry author </xsl:text><xsl:value-of select="@id"/><xsl:text> ... \n[PN]
</xsl:text>
<xsl:text>
.author
</xsl:text>
<xsl:value-of select="normalize-space(.)"/>,
<xsl:text>
./author </xsl:text><xsl:value-of select='@id'/><xsl:text>
</xsl:text></xsl:template>

<xsl:template match="msContents">
<xsl:text>
.\"begin msContents
.SH
.ft R
.smallcaps
Contents
./smallcaps
</xsl:text>
<xsl:apply-templates/><xsl:text>
</xsl:text>
.\"end msContents
.nr CINDENT 0c
.nr PI 0.5c
</xsl:template>

<xsl:template match="msItem" >
<xsl:text>
.\"Begin msItem
.nr CINDENT (\n[CINDENT]+\n[CINDELTA])
.IP "" \n[CINDENT]u
.\"in \n[CINDENT]
\fB</xsl:text><xsl:value-of select="@n" /><xsl:text>\fR </xsl:text><xsl:apply-templates/>
<xsl:text>
.nr CINDENT (\n[CINDENT]-\n[CINDELTA])
.\"End msItem
</xsl:text>
</xsl:template>

<xsl:template match="bibl/title" >

<xsl:choose>
<xsl:when test="(@type='uniform' ) or (@level='j' or @level='m')">
<xsl:text>\fI</xsl:text><xsl:apply-templates/>.<xsl:text>\fR</xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:apply-templates/>.
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="title" >
<xsl:if test="text()">
<xsl:text>
.print-index-entry title </xsl:text><xsl:value-of select='@id'/> ... \n[PN]
<xsl:choose>
<xsl:when test="(@type='uniform' ) or (@level='j' or @level='m')">
<xsl:text>
.title
</xsl:text>
\fI<xsl:apply-templates/>.\fR
<xsl:text>
./title </xsl:text> <xsl:value-of select='@id'/><xsl:text> ###--</xsl:text><xsl:value-of select='$msid'/><xsl:text> </xsl:text><xsl:value-of select='../locus/@from'/><xsl:text>--
</xsl:text>
</xsl:when><xsl:otherwise>
<xsl:text>
.title
</xsl:text>
<xsl:apply-templates/><xsl:text>
./title </xsl:text> <xsl:value-of select='@id'/><xsl:text>###--</xsl:text><xsl:value-of select="$msid"/><xsl:text> </xsl:text><xsl:value-of select="../locus/@from"/><xsl:text>--
\&amp;</xsl:text></xsl:otherwise>
</xsl:choose>
&nl;
</xsl:if>
</xsl:template>

<xsl:template match="msItem/locus">
<xsl:text>
.if !d from \{\
.ds from \*[segment] </xsl:text><xsl:value-of select="@from"/><xsl:text>
.ds startsegment \*[segment]
.\}
.ie '\*[startsegment]'\*[segment]' .ds to </xsl:text><xsl:value-of select="@to"/><xsl:text>
.el .ds to \*[segment] </xsl:text><xsl:value-of select="@to"/><xsl:text>
(</xsl:text><xsl:apply-templates/><xsl:text>)
</xsl:text>
</xsl:template>

<xsl:template match="locus"><xsl:text>
</xsl:text><xsl:apply-templates/>
</xsl:template>

<xsl:template match="incipit">
<xsl:choose>
<xsl:when test="@defective='yes'">
<xsl:text>Begins defectively:
</xsl:text></xsl:when>
<xsl:otherwise>
<xsl:text>Incipit:
</xsl:text>
</xsl:otherwise></xsl:choose><xsl:call-template name="check_lang_start"/><xsl:text>\(lq</xsl:text><xsl:apply-templates/><xsl:text>\(rq
</xsl:text><xsl:call-template name="check_lang_end"/>
</xsl:template>

<xsl:template match="explicit">
<xsl:choose>
<xsl:when test="@defective='yes'">
<xsl:text>
Ends defectively:
</xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:text>Explicit:
</xsl:text>
</xsl:otherwise>
</xsl:choose><xsl:call-template name="check_lang_start"/><xsl:text>\(lq</xsl:text><xsl:apply-templates/><xsl:text>\(rq
</xsl:text><xsl:call-template name="check_lang_end"/>
</xsl:template>

<xsl:template match="rubric">
<xsl:choose>
<xsl:when test="@defective='yes'">
<xsl:text>
Defective rubric:
</xsl:text>
</xsl:when><xsl:when test="@type='final'">
<xsl:text>
Final rubric:
</xsl:text></xsl:when><xsl:otherwise>
<xsl:text>
Rubric:
</xsl:text>
</xsl:otherwise>
</xsl:choose><xsl:call-template name="check_lang_start"/><xsl:text>\(lq</xsl:text><xsl:apply-templates/><xsl:text>\(rq
</xsl:text><xsl:call-template name="check_lang_end"/>
</xsl:template>

<xsl:template match="physDesc" >
<xsl:text>
.SH
.ft R
.smallcaps
Physical description
./smallcaps
.small
</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="form" >
<xsl:text>
.IP "" \n[PI]u
\fBForm:\fR
</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="support" >
<xsl:text>
.IP "" \n[PI]u
\fBSupport:\fR </xsl:text>
<xsl:for-each select='p'>
<xsl:apply-templates/>
</xsl:for-each>
</xsl:template>

<xsl:template match="extent" >
<xsl:text>
.IP "" \n[PI]u
\fBExtent:\fR </xsl:text><xsl:apply-templates/>
</xsl:template>

<xsl:template match="dimensions">
<xsl:text>
.IP "" \n[PI]u
\fBSize:\fR </xsl:text><xsl:value-of select="height"/> \(mu <xsl:value-of
      select="width"/> <xsl:if test="not(contains(.,'mm'))"></xsl:if>
</xsl:template>

<xsl:template match="binding/p/dimensions">
<xsl:text>
</xsl:text><xsl:value-of select="height"/> \(mu <xsl:value-of
      select="width"/> <xsl:if test="not(contains(.,'mm'))"><xsl:text> mm</xsl:text></xsl:if>
</xsl:template>

<xsl:template match="collation">
<xsl:text>
.IP "" \n[PI]u
\fBCollation\fR: </xsl:text><xsl:for-each select="p">
<xsl:apply-templates/>
</xsl:for-each>
</xsl:template>

<xsl:template match="layout">
<xsl:text>
.IP "" \n[PI]u
\fBLayout:\fR </xsl:text><xsl:for-each select="p">
<xsl:apply-templates/>
</xsl:for-each>
</xsl:template>


<xsl:template match="msHeading/origPlace">
<xsl:text>
.print-index-entry publ-place </xsl:text><xsl:value-of select="@id"/><xsl:text> ... \n[PN]
.publ-place
</xsl:text><xsl:value-of select="normalize-space(.)"/>,
<xsl:text>
./publ-place "</xsl:text><xsl:value-of select='normalize-space(.)'/> ThreeDotsInARow <xsl:value-of select="../../msIdentifier/idno"/><xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="origPlace">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="origDate">
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="msHeading/origDate">
<xsl:text>
.print-index-entry publ-date </xsl:text><xsl:value-of select="@id"/><xsl:text> ... \n[PN]
.publ-date
</xsl:text>
<xsl:apply-templates/><xsl:text>,
./publ-date  "</xsl:text><xsl:value-of select='normalize-space(.)'/> ThreeDotsInARow <xsl:value-of select="@notBefore"/>\(en<xsl:value-of select="@notAfter"/> ThreeDotsInARow <xsl:value-of select="../../msIdentifier/idno"/><xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="textLang">
<xsl:text>
.print-index-entry language </xsl:text><xsl:value-of select="@id"/><xsl:text> ... \n[PN]
.language
</xsl:text>
<xsl:apply-templates/><xsl:text>
./language </xsl:text><xsl:value-of 
                           select="concat(@id,
			   ' ThreeDotsInARow ',
			  ../../msIdentifier/idno)"/><xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="expan" >\fI<xsl:apply-templates/>\fR</xsl:template>

<xsl:template match="supplied[@reason='illegible']" >[<xsl:apply-templates/>]</xsl:template>

<xsl:template match="supplied[@reason='damage']" >[<xsl:apply-templates/>]</xsl:template>

<xsl:template match="supplied[@reason='omitted']" ><![CDATA[<]]><xsl:apply-templates/><xsl:text>&gt;</xsl:text></xsl:template>

<xsl:template match="supplied" ><xsl:apply-templates/></xsl:template>

<!--xsl:template match="supplied" >
<xsl:choose>
<xsl:when test="contains(@reason,'illegible') or contains(@reason,'damage')">[<xsl:apply-templates/>]</xsl:when>
<xsl:when test="contains(@reason,'omitted')">&lt;<xsl:apply-templates/>&gt;</xsl:when>
</xsl:choose>
</xsl:template-->

<xsl:template match="list">
<xsl:for-each select="item"><xsl:text>
.XP
</xsl:text>
<xsl:apply-templates/>
</xsl:for-each>
</xsl:template>


<xsl:template match="history" >
<xsl:text>
.big
.SH
.ft R
.smallcaps
History
./smallcaps
.small
</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="name" >
<xsl:choose>
<xsl:when test="@type = 'person'">
<xsl:text>
.print-index-entry person </xsl:text><xsl:value-of select="@id"/><xsl:text> ... \n[PN]</xsl:text>
<xsl:choose>
<xsl:when test="@reg"><xsl:text>
.person-index "</xsl:text><xsl:value-of select="@reg"/><xsl:text>
</xsl:text><xsl:call-template name="check_lang_start"/><xsl:apply-templates/><xsl:call-template name="check_lang_end"/>
</xsl:when>
<xsl:otherwise>
<xsl:text>
.person
</xsl:text>
<xsl:call-template name="check_lang_start"/><xsl:apply-templates/><xsl:call-template name="check_lang_end"/>
<xsl:text>
./person </xsl:text> <xsl:value-of select='@id'/><xsl:text>
</xsl:text></xsl:otherwise>
</xsl:choose>
</xsl:when>
<xsl:when test="@type = 'place'">
<xsl:text>
.print-index-entry place </xsl:text><xsl:value-of select="@id"/><xsl:text> ... \n[PN]</xsl:text>
<xsl:text>
.place
</xsl:text>
<xsl:call-template name="check_lang_start"/><xsl:value-of select="normalize-space(.)"/><xsl:call-template name="check_lang_end"/>
<xsl:text>
./place </xsl:text> <xsl:value-of select='@id'/><xsl:text>
</xsl:text></xsl:when>
<xsl:otherwise>
<xsl:text>
.print-index-entry name </xsl:text><xsl:value-of select="@id"/><xsl:text> ... \n[PN]</xsl:text>
 <xsl:text>
.name
</xsl:text>
<xsl:call-template name="check_lang_start"/><xsl:apply-templates/><xsl:call-template name="check_lang_end"/>
<xsl:text>
./name </xsl:text> <xsl:value-of select='@id'/><xsl:text>
</xsl:text></xsl:otherwise>
</xsl:choose><xsl:text>\&amp;</xsl:text>
</xsl:template>

<xsl:template match="origin" >
<xsl:text>
.big
.SH
.ft I
Origin
.small
</xsl:text>
<xsl:apply-templates/><xsl:text>
</xsl:text>
</xsl:template>

<xsl:template match="provenance" >
<xsl:text>
.big
.SH
.ft I
Provenance
.small
</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="acquisition" >
<xsl:text>
.big
.SH
.ft I
Acquisition
.small
</xsl:text>
<xsl:apply-templates/>&sp;
</xsl:template>


<xsl:template match="listBibl" >
<xsl:text>
.big
.SH
.ft R
.smallcaps
Bibliography
./smallcaps
.small
</xsl:text><xsl:apply-templates />
</xsl:template>

<xsl:template match="msItem/listBibl" ><xsl:text>
[</xsl:text><xsl:apply-templates /><xsl:text>]
</xsl:text>
</xsl:template>

<xsl:template match="msItem/listBibl/bibl" >
<xsl:for-each select="author" >
<xsl:text>
.author
</xsl:text>
<xsl:value-of select="normalize-space(.)"/><xsl:choose><xsl:when test="position()=1 and position()=last()"><xsl:text>:
</xsl:text></xsl:when><xsl:when test="position()=1 and not(position()=last())"><xsl:text>,
</xsl:text></xsl:when><xsl:when test="position()>1 and not(position()=last())"><xsl:text>,
</xsl:text>
</xsl:when><xsl:when test="position()>1 and position()=last()-1"><xsl:text> and </xsl:text>
</xsl:when>
</xsl:choose>
<xsl:text>
./author </xsl:text><xsl:value-of select='@id'/><xsl:text>
</xsl:text>
</xsl:for-each>
<xsl:text>
</xsl:text>
<xsl:if test="title">
<xsl:apply-templates select="title" /><xsl:text>
</xsl:text>
</xsl:if>
<xsl:for-each select="editor" >
<xsl:choose>
<xsl:when test="position()=1 and position()=last()">&sp;<xsl:apply-templates/>&sp;(ed.)&sp;</xsl:when>
<xsl:when test="position()=1 and not(position()=last())">&sp;<xsl:apply-templates/></xsl:when>
<xsl:when test="position()>1 and not(position()=last())">,&sp;<xsl:apply-templates/></xsl:when>
<xsl:when test="position()>1 and position()=last()">and&sp;<xsl:apply-templates/>&sp;(eds.)&sp;</xsl:when>
</xsl:choose>
</xsl:for-each>
<xsl:apply-templates select="imprint" /><xsl:text>
</xsl:text><xsl:apply-templates select="biblScope" /><xsl:text>
</xsl:text><xsl:apply-templates select="note" />
</xsl:template>

<xsl:template match="bibl" >
<xsl:if test="name(..)='listBibl'">
<xsl:text>
.XP
</xsl:text>
</xsl:if>
<xsl:for-each select="author" ><xsl:text>
.print-index-entry author </xsl:text><xsl:value-of select="@id"/><xsl:text> ... \n[PN]
</xsl:text>
<xsl:choose>
<xsl:when test="position()=1 and position()=last()">
<xsl:value-of select="normalize-space(.)"/><xsl:text>:
.author-index </xsl:text><xsl:value-of select="normalize-space(.)" /><xsl:text>
</xsl:text></xsl:when>
<xsl:when test="position()=1 and not(position()=last())"><xsl:text>
.author
</xsl:text><xsl:value-of select="normalize-space(.)"/><xsl:text>
./author </xsl:text><xsl:value-of select='@id'/><xsl:text>
</xsl:text></xsl:when><xsl:when test="position()>1 and not(position()=last())">,&sp;
<xsl:value-of select="normalize-space(.)"/>
.author-index <xsl:value-of select="normalize-space(.)" />&nl;
</xsl:when>
<xsl:when test="position()>1 and position()=last()">and&sp;
<xsl:value-of select="."/>:&sp;
.author-index <xsl:value-of select="normalize-space(.)" />&nl;
</xsl:when>
</xsl:choose>
</xsl:for-each>
<xsl:text>
</xsl:text>
<xsl:apply-templates select="title" />
&nl;
  <xsl:for-each select="editor" >
   <xsl:choose>
     <xsl:when test="position()=1 and position()=last()">&sp;<xsl:apply-templates/>&sp;(ed.)&sp;</xsl:when>
     <xsl:when test="position()=1 and not(position()=last())">&sp;<xsl:apply-templates/></xsl:when>
     <xsl:when test="position()>1 and not(position()=last())">,&sp;<xsl:apply-templates/></xsl:when>
     <xsl:when test="position()>1 and position()=last()">and&sp;<xsl:apply-templates/>&sp;(eds.)&sp;</xsl:when>
  </xsl:choose>
 </xsl:for-each>
<xsl:apply-templates select="imprint" /><xsl:text>
</xsl:text><xsl:apply-templates select="biblScope" />.<xsl:text>
</xsl:text><xsl:apply-templates select="note" />
</xsl:template>

<!-- This is what may occur in bibl
author
biblScope
date
editor
imprint
publisher
pubPlace
series
title
-->

<xsl:template match="imprint" >
<xsl:for-each select="pubPlace|publisher|date|biblScope">
<xsl:apply-templates/><xsl:choose><xsl:when test="position() = last()"><xsl:text>. </xsl:text></xsl:when><xsl:otherwise><xsl:text>. </xsl:text></xsl:otherwise></xsl:choose>
</xsl:for-each>&sp;
</xsl:template>

<!--
This may occur in imprint

pubPlace | publisher | date | biblScope | index | cb | lb |
milestone | pb | addSpan | delSpan | gap
-->

<xsl:template match="decoration" >
<xsl:text>
.big
.SH
.ft I
Decoration
.small
</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="decoNote" >
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="bindingDesc">
<xsl:text>
.big
.SH
.ft I
Binding
.small
</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="binding" >
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="msWriting" >
<xsl:text>
.IP
\fBScript:\fR
</xsl:text><xsl:for-each select="handDesc/p">
<xsl:apply-templates/>
</xsl:for-each>
</xsl:template>

<xsl:template match="foliation">
<xsl:text>
.big
.SH
.ft I
Foliation
.small
</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="additions">
<xsl:text>
.big
.SH
.ft I
Additions
.small
</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="condition">
<xsl:text>
.big
.SH
.ft I
Condition
.small
</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="p" >
<xsl:if test="substring-before(.,':') = 'Detailed description'"><xsl:text>
.big
.SH
.ft I
Detailed description
.small
</xsl:text></xsl:if><xsl:if test="not(name(../..)='msItem')"><xsl:text>
.PP
</xsl:text>
</xsl:if>
<xsl:if test="substring-before(.,':') = 'Detailed description'">@@@</xsl:if><xsl:apply-templates/>
</xsl:template>

<xsl:template match="additional/adminInfo" />

<xsl:template match="q">
<xsl:call-template name="check_lang_start"/><xsl:apply-templates/><xsl:call-template name="check_lang_end"/>
</xsl:template>

<xsl:template match="text()">
<xsl:text> </xsl:text><xsl:value-of select="normalize-space(.)"/>
</xsl:template>

<xsl:template name="check_lang_start"><!--
<xsl:if test="@lang='GRK'"><xsl:text>\FK</xsl:text></xsl:if>
--></xsl:template>

<xsl:template name="check_lang_end"><!--
<xsl:if test="@lang='GRK'"><xsl:text>\F(BA</xsl:text></xsl:if>
--></xsl:template>


</xsl:stylesheet>
