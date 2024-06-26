.ig
Copyright (C) 1989, 1990, 1991, 1992 Free Software Foundation, Inc.
     Written by James Clark (jjc@jclark.com)

This file is part of groff.

groff is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2, or (at your option) any later
version.

groff is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

You should have received a copy of the GNU General Public License along
with groff; see the file COPYING.  If not, write to the Free Software
Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
..
.ds MSVERSION "1.08 $Id: tmac.gs,v 1.2 1993/08/30 06:13:41 siglun Exp siglun $
.if !\n(.g .ab These ms macros require groff.
.if \n(.C \
.	ab The groff ms macros do not work in compatibility mode.
.\" Enable warnings. You can delete this if you want.
.warn
.\" See if already loaded.
.if r GS .nx
.nr GS 1
.de @error
.tm \\n(.F:\\n(.c: macro error: \\$*
..
.de @warning
.tm \\n(.F:\\n(.c: macro warning: \\$*
..
.de @fatal
.ab \\n(.F:\\n(.c: fatal macro error: \\$*
..
.de @not-implemented
.@error sorry, \\$0 not implemented
.als \\$0 @nop
..
.als TM @not-implemented
.als CT @not-implemented
.de @nop
..
.de @init
.\" a non-empty environment
.ev ne
\c
.ev
.ev nf
'nf
.ev
..
.ds REFERENCES References
.ds ABSTRACT ABSTRACT
.ds TOC Table of Contents
.ds MONTH1 January
.ds MONTH2 February
.ds MONTH3 March
.ds MONTH4 April
.ds MONTH5 May
.ds MONTH6 June
.ds MONTH7 July
.ds MONTH8 August
.ds MONTH9 September
.ds MONTH10 October
.ds MONTH11 November
.ds MONTH12 December
.ds MO \\*[MONTH\n[mo]]
.nr *year \n[yr]+1900
.ds DY \n[dy] \*[MO] \n[*year]
.de ND
.if \\n[.$] .ds DY "\\$*
..
.de DA
.if \\n[.$] .ds DY "\\$*
.ds CF \\*[DY]
..
.\" indexing
.de IXINIT
.open index index.log
.nr INDEXOPEN 1
..
.de IX
.if !rINDEXOPEN .IXINIT
.ie '\\n[.z]'' \{\
.write index \\$1\t\\$2\t\\$3\t\\$4\t\\n[PN]
.\}
.el \{\
\!.IX \\$1 "\\$2" "\\$3" "\\$4" "\\$4" \\n[PN]
.\}
..
.\" print an error message and then try to recover
.de @error-recover
.@error \\$@ (recovering)
.nr *pop-count 0
.while !'\\n(.z'' \{\
.	\"@warning automatically terminating diversion \\n(.z
.	ie d @div-end!\\n(.z .@div-end!\\n(.z
.	el .*div-end-default
.	nr *pop-count +1
.	\" ensure that we don't loop forever
.	if \\n[*pop-count]>20 .@fatal recovery failed
.\}
.while !'\\n[.ev]'0' .ev
.par@reset-env
.par@reset
..
.de *div-end-default
.ds *last-div \\n(.z
.br
.di
.ev nf
.\\*[*last-div]
.ev
..
.\" ****************************
.\" ******** module cov ********
.\" ****************************
.\" Cover sheet and first page.
.de cov*err-not-after-first-page
.@error \\$0 is not allowed after the first page has started
..
.de cov*err-not-before-tl
.@error \\$0 is not allowed before TL
..
.de cov*err-not-again
.@error \\$0 is not allowed more than once
..
.de cov*err-not-after-ab
.@error \\$0 is not allowed after first AB, LP, PP, IP, SH or NH
..
.als AU cov*err-not-before-tl
.als AI cov*err-not-before-tl
.als AB cov*err-not-before-tl
.de cov*first-page-init
.rm cov*first-page-init
.par@init
.als RP cov*err-not-after-first-page
.@init
.ie \\n[cov*rp-format] \{\
.	pg@cs-top
.	als FS cov*FS
.	als FE cov*FE
.\}
.el \{\
.	pg@top
.	als FS @FS
.	als FE @FE
.\}
.wh 0 pg@top
..
.wh 0 cov*first-page-init
.\" This handles the case where FS occurs before TL or LP.
.de FS
.br
\\*[FS]\\
..
.nr cov*rp-format 0
.nr cov*rp-no 0
.\" released paper format
.de RP
.nr cov*rp-format 1
.if \\n[.$] .if '\\$1'no' .nr cov*rp-no 1
.pn 0
..
.de TL
.br
.als TL cov*err-not-again
.rn @AB AB
.rn @AU AU
.rn @AI AI
.di cov*tl-div
.par@reset
.ft B
.ps +2
.vs +3p
.ll (u;\\n[LL]*5/6)
.nr cov*n-au 0
..
.de @AU
.par@reset
.if !'\\n(.z'' \{\
.	br
.	di
.\}
.nr cov*n-au +1
.di cov*au-div!\\n[cov*n-au]
.nf
.ft I
.ps \\n[PS]
..
.de @AI
.par@reset
.if !'\\n(.z'' \{\
.	br
.	di
.\}
.ie !\\n[cov*n-au] .@error AI before AU
.el \{\
.	di cov*ai-div!\\n[cov*n-au]
.	nf
.	ft R
.	ps \\n[PS]
.\}
..
.de LP
.if !'\\n[.z]'' \{\
.	br
.	di
.\}
.br
.cov*ab-init
.cov*print
\\*[\\$0]\\
..
.als IP LP
.als PP LP
.als XP LP
.als NH LP
.als SH LP
.als MC LP
.als RT LP
.als XS LP
.de cov*ab-init
.als cov*ab-init @nop
.als LP @LP
.als IP @IP
.als PP @PP
.als XP @XP
.als RT @RT
.als XS @XS
.als SH @SH
.als NH @NH
.als QP @QP
.als RS @RS
.als RE @RE
.als QS @QS
.als QE @QE
.als MC @MC
.als EQ @EQ
.als EN @EN
.als AB cov*err-not-after-ab
.als AU par@AU
.als AI par@AI
.als TL par@TL
..
.de @AB
.if !'\\n(.z'' \{\
.	br
.	di
.\}
.cov*ab-init
.di cov*ab-div
.par@ab-indent
.par@reset
.if !'\\$1'no' \{\
.	ft I
.	ce 1
\\*[ABSTRACT]
.	sp
.	ft R
.\}
.ns
.@LP
..
.de AE
.ie '\\n(.z'cov*ab-div' \{\
.	als AE cov*err-not-again
.	br
.	di
.\"	nr cov*ab-height \\n[dn]
.	par@reset-env
.	par@reset
.	cov*print
.\}
.el .@error AE without AB
..
.de @div-end!cov*ab-div
.AE
..
.de cov*print
.als cov*print @nop
.ie d cov*tl-div \{\
.	ie \\n[cov*rp-format] .cov*rp-print
.	el .cov*draft-print
.\}
.el \{\
.	if \\n[cov*rp-format] \{\
.		@warning RP format but no TL
.		bp 1
.		als FS @FS
.		als FE @FE
.	\}
.	br
.\}
..
.de cov*rp-print
.nr cov*page-length \\n[.p]
.pl 1000i
.cov*tl-au-print
.sp 3
.if d cov*ab-div \{\
.	nf
.	cov*ab-div
.\}
.sp 3
.par@reset
\\*[DY]
.br
.if \\n[cov*fn-height] \{\
.	sp |(u;\\n[cov*page-length]-\\n[FM]\
-\\n[cov*fn-height]-\\n[fn@sep-dist]>?\\n[nl])
.	fn@print-sep
.	ev nf
.	cov*fn-div
.	ev
.	ie \\n[cov*rp-no] .rm cov*fn-div
.	el \{\
.		rn cov*fn-div fn@overflow-div
.		nr fn@have-overflow 1
.	\}
.\}
.als FS @FS
.als FE @FE
.\" If anything was printed below where the footer line is normally printed,
.\" then that's an overflow.
.if -\\n[FM]/2+1v+\\n[cov*page-length]<\\n[nl] .@error cover sheet overflow
.pl \\n[cov*page-length]u
.bp 1
.if !\\n[cov*rp-no] .cov*tl-au-print
.rs
.sp 1
..
.de cov*draft-print
.cov*tl-au-print
.if d cov*ab-div \{\
.	nf
.	sp 1.5
.	cov*ab-div
.\}
.sp 1
..
.de cov*tl-au-print
.par@reset
.nf
.rs
.sp 3
.ce 9999
.cov*tl-div
.nr cov*i 1
.nr cov*sp 1v
.while \\n[cov*i]<=\\n[cov*n-au] \{\
.	sp \\n[cov*sp]u
.	cov*au-div!\\n[cov*i]
.	ie d cov*ai-div!\\n[cov*i] \{\
.		sp .5v	
.		cov*ai-div!\\n[cov*i]
.		nr cov*sp 1v
.	\}
.	el .nr cov*sp .5v
.	nr cov*i +1
.\}
.ce 0
..
.nr cov*fn-height 0
.nr cov*in-fn 0
.\" start of footnote on cover
.de cov*FS
.if \\n[cov*in-fn] \{\
.	@error nested FS
.	FE
.\}
.nr cov*in-fn 1
.ev fn
.par@reset-env
.da cov*fn-div
.if !\\n[cov*fn-height] .ns
.ie \\n[.$] .FP "\\$1" no
.el .@LP
..
.de @div-end!cov*fn-div
.cov*FE
..
.\" end of footnote on cover
.de cov*FE
.ie '\\n(.z'cov*fn-div' \{\
.	br
.	ev
.	di
.	nr cov*in-fn 0
.	nr cov*fn-height +\\n[dn]
.\}
.el .@error FE without matching FS
..
.\" ***************************
.\" ******** module pg ********
.\" ***************************
.\" Page-level formatting.
.\" > 0 if we have a footnote on the current page
.nr pg@fn-flag 0
.nr pg@colw 0
.nr pg@fn-colw 0
.nr HM 1i
.nr FM 1i
.nr PO 1i
.ds LF
.ds CF
.ds RF
.ds LH
.ds CH \\-\\n[PN]\\-
.ds RH
.ds pg*OH '\\*[LH]'\\*[CH]'\\*[RH]'
.ds pg*EH '\\*[LH]'\\*[CH]'\\*[RH]'
.ds pg*OF '\\*[LF]'\\*[CF]'\\*[RF]'
.ds pg*EF '\\*[LF]'\\*[CF]'\\*[RF]'
.de OH
.ds pg*\\$0 "\\$*
..
.als EH OH
.als OF OH
.als EF OH
.de PT
.ie \\n%=1 .if \\n[pg*P1] .tl \\*[pg*OH]
.el \{\
.	ie o .tl \\*[pg*OH]
.	el .tl \\*[pg*EH]
.\}
..
.de BT
.ie o .tl \\*[pg*OF]
.el .tl \\*[pg*EF]
..
.nr pg*P1 0
.de P1
.nr pg*P1 1
..
.wh -\n[FM]u pg@bottom
.wh -\n[FM]u/2u pg*footer
.nr MINGW 2n
.nr pg@ncols 1
.de @MC
.if !'\\n(.z'' .error-recover MC while diversion open
.br
.ie \\n[pg@ncols]>1 .pg@super-eject
.el \{\
.	\" flush out any floating keeps
.	while \\n[kp@tail]>\\n[kp@head] \{\
.		rs
.		bp
.	\}
.\}
.ie !\\n(.$ \{\
.	nr pg@colw \\n[LL]*7/15
.	nr pg*gutw \\n[LL]-(2*\\n[pg@colw])
.	nr pg@ncols 2
.\}
.el \{\
.	nr pg@colw (n;\\$1)<?\\n[LL]
.	ie \\n[.$]<2 .nr pg*gutw \\n[MINGW]
.	el .nr pg*gutw (n;\\$2)
.	nr pg@ncols \\n[LL]-\\n[pg@colw]/(\\n[pg@colw]+\\n[pg*gutw])+1
.	ie \\n[pg@ncols]>1 \
.		nr pg*gutw \\n[LL]-(\\n[pg@ncols]*\\n[pg@colw])/(\\n[pg@ncols]-1)
.	el .nr pg*gutw 0
.\}
.mk pg*col-top
.ns
.nr pg*col-num 0
.nr pg@fn-colw \\n[pg@colw]*5/6
.par@reset
..
.de 2C
.MC
..
.de 1C
.MC \\n[LL]u
..
.\" top of page macro
.de pg@top
.ch pg*footer -\\n[FM]u/2u
.nr PN \\n%
.nr pg*col-num 0
.nr pg@fn-bottom-margin 0
.nr pg*saved-po \\n[PO]
.po \\n[PO]u
.ev h
.par@reset
.sp (u;\\n[HM]/2)
.PT
.sp |\\n[HM]u
.if d HD .HD
.mk pg@header-bottom
.ev
.mk pg*col-top
.pg*start-col
..
.de pg*start-col
.\" Handle footnote overflow before floating keeps, because the keep
.\" might contain an embedded footnote.
.fn@top-hook
.kp@top-hook
.tbl@top-hook
.ns
..
.de pg@cs-top
.sp \\n[HM]u
.\" move pg@bottom and pg*footer out of the way
.ch pg@bottom \\n[.p]u*2u
.ch pg*footer \\n[.p]u*2u
.ns
..
.de pg@bottom
.tbl@bottom-hook
.if \\n[pg@fn-flag] .fn@bottom-hook
.nr pg*col-num +1
.ie \\n[pg*col-num]<\\n[pg@ncols] .pg*end-col
.el .pg*end-page
..
.de pg*end-col
'sp |\\n[pg*col-top]u
.po (u;\\n[pg*saved-po]+(\\n[pg@colw]+\\n[pg*gutw]*\\n[pg*col-num]))
.\"po +(u;\\n[pg@colw]+\\n[pg*gutw])
.pg*start-col
..
.de pg*end-page
.po \\n[pg*saved-po]u
.\" Make sure we don't exit if there are still floats or footnotes left-over.
.ie \\n[kp@head]<\\n[kp@tail]:\\n[fn@have-overflow] \{\
.	\" Switching environments ensures that we don't get an unnecessary
.	\" blank line at the top of the page.
.	ev ne
'	bp
.	ev
.\}
.el \{\
.	\" If the text has ended and there are no more footnotes or keeps, exit.
.	if \\n[pg@text-ended] .ex
.	if r pg*next-number \{\
.		pn \\n[pg*next-number]
.		rr pg*next-number
.		if d pg*next-format \{\
.			af PN \\*[pg*next-format]
.			rm pg*next-format
.		\}
.	\}
'	bp
.\}
..
.\" pg@begin number format
.de pg@begin
.ie \\n[.$]>0 \{\
.	nr pg*next-number (;\\$1)
.	ie \\n[.$]>1 .ds pg*next-format \\$2
.	el .rm pg*next-format
.\}
.el .rr pg*next-number
.pg@super-eject
..
.\" print the footer line
.de pg*footer
.ev h
.par@reset
.BT
.ev
..
.\" flush out any keeps or footnotes
.de pg@super-eject
.br
.if !'\\n(.z'' .@error-recover diversion open while ejecting page
.\" Make sure we stay in the end macro while there is still footnote overflow
.\" left, or floating keeps.
.while \\n[kp@tail]>\\n[kp@head]:\\n[pg@fn-flag] \{\
.	rs
.	bp
.\}
.bp
..
.nr pg@text-ended 0
.de pg@end-text
.br
.nr pg@text-ended 1
.pg@super-eject
..
.em pg@end-text
.\" ***************************
.\" ******** module fn ********
.\" ***************************
.\" Footnotes.
.nr fn@sep-dist 8p
.ev fn
.\" Round it vertically
.vs \n[fn@sep-dist]u
.nr fn@sep-dist \n[.v]
.ev
.nr fn*text-num 0 1
.nr fn*note-num 0 1
.ds * \\*[par@sup-start]\En+[fn*text-num]\\*[par@sup-end]
.nr fn*open 0
.\" normal FS
.de @FS
.ie \\n[.$] .fn*do-FS "\\$1" no
.el \{\
.	ie \\n[fn*text-num]>\\n[fn*note-num] .fn*do-FS \\n+[fn*note-num]
.	el .fn*do-FS
.\}
..
.\" Second argument of `no' means don't embellish the first argument.
.de fn*do-FS
.if \\n[fn*open] .@error-recover nested FS
.nr fn*open 1
.if \\n[.u] \{\
.	\" Ensure that the first line of the footnote is on the same page
.	\" as the reference.  I think this is minimal.
.	ev fn
.	nr fn*need 1v
.	ev
.	ie \\n[pg@fn-flag] .nr fn*need +\\n[fn:PD]
.	el .nr fn*need +\\n[fn@sep-dist]
.	ne \\n[fn*need]u+\\n[.V]u>?0
.\}
.ev fn
.par@reset-env
.fn*start-div
.par@reset
.ie \\n[.$] .FP \\$@
.el .@LP
..
.de @FE
.ie !\\n[fn*open] .@error FE without FS
.el \{\
.	nr fn*open 0
.	br
.	ev
.	fn*end-div
.\}
..
.nr fn@have-overflow 0
.\" called at the top of each column
.de fn@top-hook
.nr fn*max-width 0
.nr fn*page-bottom-pos 0-\\n[FM]-\\n[pg@fn-bottom-margin]
.ch pg@bottom \\n[fn*page-bottom-pos]u
.if \\n[fn@have-overflow] \{\
.	nr fn@have-overflow 0
.	fn*start-div
.	ev nf
.	fn@overflow-div
.	ev
.	fn*end-div
.\}
..
.\" This is called at the bottom of the column if pg@fn-flag is set.
.de fn@bottom-hook
.nr pg@fn-flag 0
.nr fn@have-overflow 0
.nr fn@bottom-pos \\n[.p]-\\n[FM]-\\n[pg@fn-bottom-margin]+\\n[.v]
.ev fn
.nr fn@bottom-pos -\\n[.v]
.ev
.ie \\n[nl]+\\n[fn@sep-dist]+\n[.V]>\\n[fn@bottom-pos] \{\
.	rn fn@div fn@overflow-div
.	nr fn@have-overflow 1
.\}
.el \{\
.	if \\n[pg@ncols]>1 \
.		if \\n[fn*max-width]>\\n[pg@fn-colw] \
.			nr pg@fn-bottom-margin \\n[.p]-\\n[FM]-\\n[nl]+1v
.	wh \\n[fn@bottom-pos]u fn*catch-overflow
.	fn@print-sep
.	ev nf
.	fn@div
.	rm fn@div
.	ev
.	if '\\n(.z'fn@overflow-div' \{\
.		di
.		nr fn@have-overflow \\n[dn]>0
.	\}
.	ch fn*catch-overflow
.\}
..
.de fn*catch-overflow
.di fn@overflow-div
..
.nr fn*embed-count 0
.de @div-end!fn@div
.br
.if '\\n[.ev]'fn' .ev
.fn*end-div
.nr fn*open 0
..
.als @div-end!fn*embed-div @div-end!fn@div
.de fn*start-div
.ie '\\n(.z'' \{\
.	da fn@div
.	if !\\n[pg@fn-flag] .ns
.\}
.el .di fn*embed-div
..
.de fn*end-div
.ie '\\n(.z'fn@div' \{\
.	di
.	nr fn*page-bottom-pos -\\n[dn]
.	nr fn*max-width \\n[fn*max-width]>?\\n[dl]
.	if !\\n[pg@fn-flag] .nr fn*page-bottom-pos -\\n[fn@sep-dist]
.	nr pg@fn-flag 1
.	nr fn*page-bottom-pos \\n[nl]-\\n[.p]+\n[.V]>?\\n[fn*page-bottom-pos]
.	ch pg@bottom \\n[fn*page-bottom-pos]u
.\}
.el \{\
.	ie '\\n(.z'fn*embed-div' \{\
.	di
.		rn fn*embed-div fn*embed-div!\\n[fn*embed-count]
\!.		fn*embed-start \\n[fn*embed-count]
.		rs
'		sp (u;\\n[dn]+\\n[fn@sep-dist]+\\n[.V])
\!.		fn*embed-end
.		nr fn*embed-count +1
.	\}
.	el \{\
.		ev fn
.		@error-recover unclosed diversion within footnote
.	\}
.\}
..
.de fn*embed-start
.ie '\\n(.z'' \{\
.	fn*start-div
.	ev nf
.	fn*embed-div!\\$1
.	rm fn*embed-div!\\$1
.	ev
.	fn*end-div
.	di fn*null
.\}
.el \{\
\!.	fn*embed-start \\$1
.	rs
.\}
..
.de fn*embed-end
.ie '\\n(.z'fn*null' \{\
.	di
.	rm fn*null
.\}
.el \!.fn*embed-end
..
.\" It's important that fn@print-sep use up exactly fn@sep-dist vertical space.
.de fn@print-sep
.ev fn
.in 0
.vs \\n[fn@sep-dist]u
\D'l 1i 0'
.br
.ev
..
.\" ***************************
.\" ******** module kp ********
.\" ***************************
.\" Keeps.
.de KS
.br
.di kp*div
..
.de KF
.if !'\\n(.z'' .@error-recover KF while open diversion
.di kp*fdiv
.ev k
.par@reset-env
.par@reset
..
.de KE
.ie '\\n(.z'kp*div' .kp*end
.el \{\
.	ie '\\n(.z'kp*fdiv' .kp*fend
.	el .@error KE without KS or KF
.\}
..
.de @div-end!kp*div
.kp*end
..
.de @div-end!kp*fdiv
.kp*fend
..
.de kp*need
.ie '\\n(.z'' .ds@need \\$1
.el \!.kp*need \\$1
..
.\" end non-floating keep
.de kp*end
.br
.di
.kp*need \\n[dn]
.ev nf
.kp*div
.ev
.rm kp*div
..
.\" Floating keeps.
.nr kp@head 0
.nr kp@tail 0
.\" end floating keep
.de kp*fend
.br
.ev
.di
.ie \\n[.t]-(\\n[.k]>0*1v)>\\n[dn] \{\
.	br
.	ev nf
.	kp*fdiv
.	rm kp*fdiv
.	ev
.\}
.el \{\
.	rn kp*fdiv kp*div!\\n[kp@tail]
.	nr kp*ht!\\n[kp@tail] 0\\n[dn]
.	nr kp@tail +1
.\}
..
.\" top of page processing for KF
.nr kp*doing-top 0
.de kp@top-hook
.if !\\n[kp*doing-top] \{\
.	nr kp*doing-top 1
.	kp*do-top
.	nr kp*doing-top 0
.\}
..
.de kp*do-top
.\" If the first keep won't fit, only force it out if we haven't had a footnote
.\" and we're at the top of the page.
.nr kp*force \\n[pg@fn-flag]=0&(\\n[nl]<=\\n[pg@header-bottom])
.nr kp*fits 1
.while \\n[kp@tail]>\\n[kp@head]&\\n[kp*fits] \{\
.	ie \\n[.t]>\\n[kp*ht!\\n[kp@head]]:\\n[kp*force] \{\
.		nr kp*force 0
.		\" It's important to advance kp@head before bringing
.		\" back the keep, so that if the last line of the
.		\" last keep springs the bottom of page trap, a new
.		\" page will not be started unnecessarily.
.		rn kp*div!\\n[kp@head] kp*temp
.		nr kp@head +1
.		ev nf
.		kp*temp
.		ev
.		rm kp*temp
.	\}
.	el .nr kp*fits 0
.\}
..
.\" ***************************
.\" ******** module ds ********
.\" ***************************
.\" Displays and non-floating keeps.
.de DE
.ds*end!\\n[\\n[.ev]:ds-type]
.nr \\n[.ev]:ds-type 0
..
.de ds@auto-end
.if \\n[\\n[.ev]:ds-type] \{\
.	@error automatically terminating display
.	DE
.\}
..
.de @div-end!ds*div
.ie \\n[\\n[.ev]:ds-type] .DE
.el .ds*end!2
..
.de ds*end!0
.@error DE without DS, ID, CD, LD or BD
..
.de LD
.br
.nr \\n[.ev]:ds-type 1
.par@reset
.nf
.sp \\n[DD]u
..
.de ID
.LD
.ie \\n[.$] .in +(n;\\$1)
.el .in +\\n[DI]u
..
.de CD
.LD
.ce 9999
..
.de RD
.LD
.rj 9999
..
.de ds*common-end
.par@reset
.sp \\n[DD]u
..
.als ds*end!1 ds*common-end
.de BD
.LD
.nr \\n[.ev]:ds-type 2
.di ds*div
..
.de ds*end!2
.br
.ie '\\n(.z'ds*div' \{\
.	di
.	nf
.	in (u;\\n[.l]-\\n[dl]/2)
.	ds*div
.	rm ds*div
.	ds*common-end
.\}
.el .@error-recover mismatched DE
..
.de DS
.br
.di ds*div
.ie '\\$1'B' \{\
.	LD
.	nr \\n[.ev]:ds-type 4
.\}
.el \{\
.	ie '\\$1'L' .LD
.	el \{\
.		ie '\\$1'C' .CD
.		el \{\
.			ie '\\$1'R' .RD
.			el \{\
.				ie '\\$1'I' .ID \\$2
.				el .ID \\$1
.			\}
.		\}
.	\}
.	nr \\n[.ev]:ds-type 3
.\}
..
.de ds@need
.if '\\n(.z'' \{\
.	while \\n[.t]<=(\\$1)&(\\n[nl]>\\n[pg@header-bottom]) \{\
.		rs
'		sp \\n[.t]u
.	\}
.\}
..
.de ds*end!3
.br
.ie '\\n(.z'ds*div' \{\
.	di
.	ds@need \\n[dn]
.	ev nf
.	ds*div
.	ev
.	rm ds*div
.	ds*common-end
.\}
.el .@error-recover mismatched DE
..
.de ds*end!4
.ie '\\n(.z'ds*div' \{\
.	br
.	di
.	nf
.	in (u;\\n[.l]-\\n[dl]/2)
.	ds@need \\n[dn]
.	ds*div
.	rm ds*div
.	ds*common-end
.\}
.el .@error-recover mismatched DE
..
.\" ****************************
.\" ******** module par ********
.\" ****************************
.\" Paragraph-level formatting.
.nr PS 10
.nr LL 6i
.de par*vs
.\" If it's too big to be in points, treat it as units.
.ie (p;\\$1)>=40p .vs (u;\\$1)
.el .vs (p;\\$1)
..
.de par@ab-indent
.nr 0:li (u;\\n[LL]/12)
.nr 0:ri \\n[0:li]
..
.de par*env-init
.aln \\n[.ev]:PS PS
.aln \\n[.ev]:VS VS
.aln \\n[.ev]:LL LL
.aln \\n[.ev]:MCLL LL
.aln \\n[.ev]:LT LT
.aln \\n[.ev]:MCLT LT
.aln \\n[.ev]:PI PI
.aln \\n[.ev]:PD PD
.ad \\n[par*adj]
.par@reset-env
..
.\" happens when the first page begins
.de par@init
.if !rLT .nr LT \\n[LL]
.if !rFL .nr FL \\n[LL]*5/6
.if !rVS .nr VS \\n[PS]+2
.ps \\n[PS]
.if !rDI .nr DI .5i
.if !rQI .nr QI 5n
.if !rPI .nr PI 5n
.par*vs \\n[VS]
.if !rPD .nr PD .3v>?\n(.V
.if !rDD .nr DD .5v>?\n(.V
.if !dFAM .ds FAM \\n[.fam]
.nr par*adj \\n[.j]
.par*env-init
.ev h
.par*env-init
.ev
.ev fn
.par*env-init
.ev
.ev k
.par*env-init
.ev
.aln 0:MCLL pg@colw
.aln 0:MCLT pg@colw
.aln k:MCLL pg@colw
.aln k:MCLT pg@colw
.if !rFPS .nr FPS \\n[PS]-2
.if !rFVS .nr FVS \\n[FPS]+2
.if !rFI .nr FI 2n
.if !rFPD .nr FPD \\n[PD]/2
.aln fn:PS FPS
.aln fn:VS FVS
.aln fn:LL FL
.aln fn:LT FL
.aln fn:PI FI
.aln fn:PD FPD
.aln fn:MCLL pg@fn-colw
.aln fn:MCLT pg@fn-colw
..
.de par@reset-env
.nr \\n[.ev]:il 0
.nr \\n[.ev]:li 0
.nr \\n[.ev]:ri 0
.nr \\n[.ev]:ai \\n[\\n[.ev]:PI]
.nr \\n[.ev]:pli 0
.nr \\n[.ev]:pri 0
.nr \\n[.ev]:ds-type 0
..
.\" par@reset
.de par@reset
.br
.ce 0
.rj 0
.ul 0
.fi
.ie \\n[pg@ncols]>1 \{\
.	ll (u;\\n[\\n[.ev]:MCLL]-\\n[\\n[.ev]:ri]-\\n[\\n[.ev]:pri])
.	lt \\n[\\n[.ev]:MCLT]u
.\}
.el \{\
.	ll (u;\\n[\\n[.ev]:LL]-\\n[\\n[.ev]:ri]-\\n[\\n[.ev]:pri])
.	lt \\n[\\n[.ev]:LT]u
.\}
.in (u;\\n[\\n[.ev]:li]+\\n[\\n[.ev]:pli])
.ft 1
.fam \\*[FAM]
.ps \\n[\\n[.ev]:PS]
.par*vs \\n[\\n[.ev]:VS]
.ls 1
.TA
.hy 14
..
.als @RT par@reset
.\" This can be redefined by the user.
.de TA
.ta T 5n
..
.de par*start
.ds@auto-end
.nr \\n[.ev]:pli \\$1
.nr \\n[.ev]:pri \\$2
.par@reset
.ie '\\$0'pp*start' .sp \\n[\\n[.ev]:VS]u\" A hack. Normal spacing, PD, between
.el .sp \\n[\\n[.ev]:PD]u	\"LP, QP etc. A VS after a PP
.ne 1v+\\n(.Vu
..
.als pp*start par*start
.de par@finish
.nr \\n[.ev]:pli 0
.nr \\n[.ev]:pri 0
.par@reset
..
.\" normal LP
.de @LP
.par*start 0 0
.nr \\n[.ev]:ai \\n[\\n[.ev]:PI]
..
.de @PP
.pp*start 0 0
.nr \\n[.ev]:ai \\n[\\n[.ev]:PI]
.ti +\\n[\\n[.ev]:ai]u
..
.de @QP
.nr \\n[.ev]:ai \\n[\\n[.ev]:PI]
.pp*start \\n[QI] \\n[QI]
..
.de @XP
.pp*start \\n[\\n[.ev]:PI] 0
.ti -\\n[\\n[.ev]:PI]u
..
.de @IP
.if \\n[.$]>1 .nr \\n[.ev]:ai (n;\\$2)
.par*start \\n[\\n[.ev]:ai] 0
.if !'\\$1'' \{\
.	\" Divert the label so as to freeze any spaces.
.	di par*label
.	in 0
.	nf
\&\\$1
.	di
.	in
.	fi
.	chop par*label
.	ti -\\n[\\n[.ev]:ai]u
.	ie \\n[dl]+1n<=\\n[\\n[.ev]:ai] \\*[par*label]\h'|\\n[\\n[.ev]:ai]u'\c
.	el \{\
\\*[par*label]
.	br
.	\}
.	rm par*label
.\}
..
.de @RS
.br
.nr \\n[.ev]:li!\\n[\\n[.ev]:il] \\n[\\n[.ev]:li]
.nr \\n[.ev]:ri!\\n[\\n[.ev]:il] \\n[\\n[.ev]:ri]
.nr \\n[.ev]:ai!\\n[\\n[.ev]:il] \\n[\\n[.ev]:ai]
.nr \\n[.ev]:pli!\\n[\\n[.ev]:il] \\n[\\n[.ev]:pli]
.nr \\n[.ev]:pri!\\n[\\n[.ev]:il] \\n[\\n[.ev]:pri]
.nr \\n[.ev]:il +1
.nr \\n[.ev]:li +\\n[\\n[.ev]:ai]
.nr \\n[.ev]:ai \\n[\\n[.ev]:PI]
.par@reset
..
.de @RE
.br
.ie \\n[\\n[.ev]:il] \{\
.	nr \\n[.ev]:il -1
.	nr \\n[.ev]:ai \\n[\\n[.ev]:ai!\\n[\\n[.ev]:il]]
.	nr \\n[.ev]:li \\n[\\n[.ev]:li!\\n[\\n[.ev]:il]]
.	nr \\n[.ev]:ri \\n[\\n[.ev]:ri!\\n[\\n[.ev]:il]]
.	nr \\n[.ev]:pli \\n[\\n[.ev]:pli!\\n[\\n[.ev]:il]]
.	nr \\n[.ev]:pri \\n[\\n[.ev]:pri!\\n[\\n[.ev]:il]]
.\}
.el .@error unbalanced \\$0
.par@reset
..
.de @QS
.br
.nr \\n[.ev]:li!\\n[\\n[.ev]:il] \\n[\\n[.ev]:li]
.nr \\n[.ev]:ri!\\n[\\n[.ev]:il] \\n[\\n[.ev]:ri]
.nr \\n[.ev]:ai!\\n[\\n[.ev]:il] \\n[\\n[.ev]:ai]
.nr \\n[.ev]:pli!\\n[\\n[.ev]:il] \\n[\\n[.ev]:pli]
.nr \\n[.ev]:pri!\\n[\\n[.ev]:il] \\n[\\n[.ev]:pri]
.nr \\n[.ev]:il +1
.nr \\n[.ev]:li +\\n[QI]
.nr \\n[.ev]:ri +\\n[QI]
.nr \\n[.ev]:ai \\n[\\n[.ev]:PI]
.par@reset
..
.als @QE @RE
.\" start boxed text
.de B1
.br
.di par*box-div
.nr \\n[.ev]:li +1n
.nr \\n[.ev]:ri +1n
.par@reset
..
.de @div-end!par*box-div
.B2
..
.\" end boxed text
.\" Postpone the drawing of the box until we're in the top-level diversion,
.\" in case there's a footnote inside the box.
.de B2
.ie '\\n(.z'par*box-div' \{\
.	br
.	di
.	ds@need \\n[dn]
.	par*box-mark-top
.	ev nf
.	par*box-div
.	ev
.	nr \\n[.ev]:ri -1n
.	nr \\n[.ev]:li -1n
.	par@finish
.	par*box-draw \\n[.i]u \\n[.l]u
.\}
.el .@error B2 without B1
..
.de par*box-mark-top
.ie '\\n[.z]'' .mk par*box-top
.el \!.par*box-mark-top
..
.de par*box-draw
.ie '\\n[.z]'' \{\
.	nr par*box-in \\n[.i]
.	nr par*box-ll \\n[.l]
.	nr par*box-vpt \\n[.vpt]
.	vpt 0
.	in \\$1
.	ll \\$2
\v'-1v+.25m'\
\D'l (u;\\n[.l]-\\n[.i]) 0'\
\D'l 0 |\\n[par*box-top]u'\
\D'l -(u;\\n[.l]-\\n[.i]) 0'\
\D'l 0 -|\\n[par*box-top]u'
.	br
.	sp -1
.	in \\n[par*box-in]u
.	ll \\n[par*box-ll]u
.	vpt \\n[par*box-vpt]
.\}
.el \!.par*box-draw \\$1 \\$2
..
.de @SH
.par@finish
.\" Keep together the heading and the first two lines of the next paragraph.
.ne 3v+\\n[\\n[.ev]:PD]u+\\n(.Vu
.sp 1
.ft B
..
.\" TL, AU, and AI are aliased to these in cov*ab-init.
.de par@TL
.par@finish
.sp 1
.ft B
.ps +2
.vs +3p
.ce 9999
..
.de par@AU
.par@finish
.sp 1
.ft I
.ce 9999
..
.de par@AI
.par@finish
.sp .5
.ce 9999
..
.\" In paragraph macros.
.de NL
.ps \\n[\\n[.ev]:PS]
..
.de SM
.ps -2
..
.de LG
.ps +2
..
.de R
.ft R
..
.\" par*define-font-macro macro font
.de par*define-font-macro
.de \\$1
.ie \\\\n[.$] \{\
.	nr par*prev-font \\\\n[.f]
\&\\\\$3\f[\\$2]\\\\$1\f[\\\\n[par*prev-font]]\\\\$2
.\}
.el .ft \\$2
\\..
..
.par*define-font-macro B B
.par*define-font-macro I I
.par*define-font-macro BI BI
.par*define-font-macro CW CR
.\" underline a word
.de UL
\Z'\\$1'\v'.25m'\D'l \w'\\$1'u 0'\v'-.25m'\\$2
..
.\" box a word
.de BX
.nr par*bxw \w'\\$1'+.4m
\Z'\v'.25m'\D'l 0 -1m'\D'l \\n[par*bxw]u 0'\D'l 0 1m'\D'l -\\n[par*bxw]u 0''\
\Z'\h'.2m'\\$1'\
\h'\\n[par*bxw]u'
..
.\" The first time UX is used, put a registered mark after it.
.ds par*ux-rg \(rg
.de UX
\s[\\n[.s]*8u/10u]UNIX\s0\\$1\\*[par*ux-rg]
.ds par*ux-rg
..
.ds par@sup-start \v'-.9m\s'\En[.s]*7u/10u'+.7m'
.als { par@sup-start
.ds par@sup-end \v'-.7m\s0+.9m'
.als } par@sup-end
.\" footnote paragraphs
.\" FF is the footnote format
.nr FF 0
.\" This can be redefined. It gets a second argument of `no' if the first
.\" argument was supplied by the user, rather than automatically.
.de FP
.br
.if !d par*fp!\\n[FF] \{\
.	@error unknown footnote format `\\n[FF]'
.	nr FF 0
.\}
.ie '\\$2'no' .par*fp!\\n[FF]-no "\\$1"
.el .par*fp!\\n[FF] "\\$1"
..
.de par*fp!0
.@PP
\&\\*[par@sup-start]\\$1\\*[par@sup-end]\ \c
..
.de par*fp!0-no
.@PP
\&\\$1\ \c
..
.de par*fp!1
.@PP
\&\\$1.\ \c
..
.de par*fp!1-no
.@PP
\&\\$1\ \c
..
.de par*fp!2
.@LP
\&\\$1.\ \c
..
.de par*fp!2-no
.@LP
\&\\$1\ \c
..
.de par*fp!3
.@IP "\\$1." (u;\\n[\\n[.ev]:PI]*2)
..
.de par*fp!3-no
.@IP "\\$1" (u;\\n[\\n[.ev]:PI]*2)
..
.\" ***************************
.\" ******** module nh ********
.\" ***************************
.\" Numbered headings.
.\" nh*hl is the level of the last heading
.nr nh*hl 0
.\" numbered heading
.de @NH
.ie '\\$1'S' \{\
.	shift
.	nr nh*hl 0
.	while \\n[.$] \{\
.		nr nh*hl +1
.		nr H\\n[nh*hl] 0\\$1
.		shift
.	\}
.	if !\\n[nh*hl] \{\
.		nr H1 1
.		nr nh*hl 1
.		@error missing arguments to .NH S
.	\}
.\}
.el \{\
.	nr nh*ohl \\n[nh*hl]
.	ie \\n[.$] \{\
.		nr nh*hl 0\\$1
.		ie \\n[nh*hl]<=0 \{\
.			nr nh*ohl 0
.			nr nh*hl 1
.		\}
.		el \{\
.			if \\n[nh*hl]-\\n[nh*ohl]>1 \
.				@warning .NH \\n[nh*ohl] followed by .NH \\n[nh*hl]
.		\}
.	\}
.	el .nr nh*hl 1
.	while \\n[nh*hl]>\\n[nh*ohl] \{\
.		nr nh*ohl +1
.		nr H\\n[nh*ohl] 0
.	\}
.	nr H\\n[nh*hl] +1
.\}
.ds SN
.nr nh*i 0
.while \\n[nh*i]<\\n[nh*hl] \{\
.	nr nh*i +1
.	as SN \\n[H\\n[nh*i]].
.\}
.SH
\\*[SN]
..
.\" ****************************
.\" ******** module toc ********
.\" ****************************
.\" Table of contents generation.
.de @XS
.da toc*div
.ev h
.ie \\n[.$] .XA "\\$1"
.el .XA
..
.de @div-end!toc*div
.XE
..
.de XA
.ie '\\n(.z'toc*div' \{\
.	if d toc*num .toc*end-entry
.	ie \\n[.$] \{\
.		ie '\\$1'no' .ds toc*num
.		el .ds toc*num "\\$1
.	\}
.	el .ds toc*num \\n[PN]
.	LP
.	na
.	ll -8n
.	in (n;0\\$2)
.\}
.el .@error XA without XS
..
.de XE
.ie '\\n(.z'toc*div' \{\
.	if d toc*num .toc*end-entry
.	ev
.	di
.\}
.el .@error XS without XE
..
.de toc*end-entry
\\a\\t\\*[toc*num]
.br
.rm toc*num
..
.de PX
.1C
.if !'\\$1'no' \{\
.	ce 1
.	ps \\n[PS]+2
.	ft B
\\*[TOC]
.	ft
.	ps
.\}
.nf
.char \[toc*leader-char] .\h'1m'
.lc \[toc*leader-char]
.ta (u;\\n[.l]-\\n[.i]-\w'000') (u;\\n[.l]-\\n[.i])R
.sp 2
.toc*div
.par@reset
..
.\" print the table of contents on page i
.de TC
.P1
.pg@begin 1 i
.PX \\$1
..
.\" ****************************
.\" ******** module eqn ********
.\" ****************************
.\" Eqn support.
.de EQ
..
.de EN
..
.de @EQ
.br
.ds eqn*num "\\$2
.ie '\\$1'L' .nr eqn*type 0
.el \{\
.	ie '\\$1'I' .nr eqn*type 1
.	el \{\
.		nr eqn*type 2
.		if !'\\$1'C' .ds eqn*num "\\$1
.	\}
.\}
.di eqn*div
.in 0
.nf
..
.de @div-end!eqn*div
.@EN
..
.\" Note that geqn mark and lineup work correctly in centered equations.
.de @EN
.ie !'\\n(.z'eqn*div' .@error-recover mismatched EN
.el \{\
.	br
.	di
.	nr eqn*have-num 0
.	if !'\\*[eqn*num]'' .nr eqn*have-num 1
.	if \\n[dl]:\\n[eqn*have-num] \{\
.		sp \\n[DD]u
.		par@reset
.		ds eqn*tabs \\n[.tabs]
.		nf
.		ie \\n[dl] \{\
.			ds@need \\n[dn]u-1v+\n[.V]u
.			chop eqn*div
.			ie \\n[eqn*type]=0 \{\
.				ta (u;\\n[.l]-\\n[.i])R
\\*[eqn*div]\t\\*[eqn*num]
.			\}
.			el \{\
.				ie \\n[eqn*type]=1 .ta \\n[DI]u \
(u;\\n[.l]-\\n[.i])R
.				el .ta (u;\\n[.l]-\\n[.i]/2)C \
(u;\\n[.l]-\\n[.i])R
\t\\*[eqn*div]\t\\*[eqn*num]
.			\}
.		\}
.		el \{\
.			ta (u;\\n[.l]-\\n[.i])R
\t\\*[eqn*num]
.		\}
.		sp \\n[DD]u
.		fi
.		ta \\*[eqn*tabs]
.	\}
.\}
..
.\" ****************************
.\" ******** module tbl ********
.\" ****************************
.\" Tbl support.
.nr tbl*have-header 0
.de TS
.\" The break is necessary in the case where the first page has not yet begun.
.br
.sp \\n[DD]u
.if '\\$1'H' .di tbl*header-div
..
.de tbl@top-hook
.if \\n[tbl*have-header] \{\
.	ie \\n[.t]-\\n[tbl*header-ht]-1v .tbl*print-header
.	el .sp \\n[.t]u
.\}
..
.de tbl*print-header
.ev nf
.tbl*header-div
.ev
.mk #T
..
.de TH
.ie '\\n[.z]'tbl*header-div' \{\
.	nr T. 0
.	T#
.	br
.	di
.	ie \\n[dn]+\\n[FM]+\\n[HM]+2v>=\\n[.p] \{\
.		@error ridiculously long table header
.		ds@need \\n[dn]
.		tbl*print-header
.	\}
.	el \{\
.		nr tbl*header-ht \\n[dn]
.		ds@need \\n[dn]u+1v
.		tbl*print-header
.		nr tbl*have-header 1
.	\}
.\}
.el .@error-recover .TH without .TS H
..
.de @div-end!tbl*header-div
.TH
.TE
..
.de TE
.ie '\\n(.z'tbl*header-div' .@error-recover .TS H but no .TH before .TE
.el \{\
.	nr tbl*have-header 0
.	sp \\n[DD]u
.\}
.\" reset tabs
.TA
..
.de tbl@bottom-hook
.if \\n[tbl*have-header] \{\
.	nr T. 1
.	T#
.\}
..
.de T&
..
.\" ****************************
.\" ******** module pic ********
.\" ****************************
.\" Pic support.
.\" PS height width
.de PS
.br
.sp \\n[DD]u
.ie \\n[.$]<2 .@error bad arguments to PS (not preprocessed with pic?)
.el \{\
.	ds@need (u;\\$1)+1v
.	in +(u;\\n[.l]-\\n[.i]-\\$2/2>?0)
.\}
..
.de PE
.par@reset
.sp \\n[DD]u+.5m
..
.\" ****************************
.\" ******** module ref ********
.\" ****************************
.\" Refer support.
.de ]-
.rm [A [B [C [D [E [G [I [J [N [O [P [Q [R [S [T [V
.rm ref*string
..
.\" Other
.ds ref*spec!0 Q A D T1 S V N P I C O
.\" Journal article
.ds ref*spec!1 Q A D T2 J S V N P I C O
.\" Book
.ds ref*spec!2 Q A D T1 S V P I C O
.\" Article within book
.ds ref*spec!3 Q A D T2 E B S V P I C O
.\" Tech report
.ds ref*spec!4 Q A D T2 R G P I C O
.\" ][ type
.de ][
.if r [T \{\
.	als [T1 [T
.	als [T2 [T
.\}
.ie d ref*spec!\\$1 .ref*build \\*[ref*spec!\\$1]
.el \{\
.	@error unknown reference type `\\$1'
.	ref*build \\*[ref*spec!0]
.\}
.ref*print
.rm ref*string
.rm [F [T1 [T2
..
.\" start of reference number
.ds [. \\*[par@sup-start]
.\" end of reference number
.ds .] \\*[par@sup-end]
.\" period before reference
.ds <. .
.\" period after reference
.ds >. \" empty
.\" comma before reference
.ds <, ,
.\" comma after reference
.ds >, \" empty
.\" start collected references
.de ]<
.als ref*print ref*end-print
.SH
\&\\*[REFERENCES]
.par@reset
..
.\" end collected references
.de ]>
.par@finish
.als ref*print ref*normal-print
..
.de ref*normal-print
.ie d [F .FS "\\*([.\\*([F\\*(.]"
.el .FS \&
\\*[ref*string]
.FE
..
.de ref*end-print
.ie d [F .IP "\\*([F."
.el .XP
\\*[ref*string]
..
.als ref*print ref*normal-print
.de ref*build
.rm ref*string ref*post-punct
.nr ref*suppress-period 1
.while \\n[.$] \{\
.	if d [\\$1 \{\
.		ie d ref*add-\\$1 .ref*add-\\$1
.		el .ref*add-dflt \\$1
.	\}
.	shift
.\}
.\" now add a final period
.ie d ref*string \{\
.	if !\\n[ref*suppress-period] .as ref*string .
.	if d ref*post-punct \{\
.		as ref*string "\\*[ref*post-punct]
.		rm ref*post-punct
.	\}
.\}
.el .ds ref*string
..
.de ref*add-T1
.ref*field T . "\fI" "" "\fP"
.if r [T .nr ref*suppress-period \\n([T
..
.de ref*add-T2
.ref*field T . "" "" ""
.if r [T .nr ref*suppress-period \\n([T
..
.de ref*add-P
.ie d [B \{\
.	ie '\\n[.hla]'se' .ref*field P , "s. " ". "
.	el \{\
.		ie \\n([P>0 .ref*field P , "pp. " ". "
.		el .ref*field P , "p. " ". "
.	\}
.\}
.el .ref*field P ":"
..
.de ref*add-J
.ref*field J "" \fI "" \fP ""
..
.de ref*add-D
.ref*field D , "" ""
..
.de ref*add-I
.ref*field I
..
.de ref*add-E
.ie '\\n[.hla]'se' \{\
.	ie \\n([E>0 .ref*field E " I:" "" " (red.),"
.	el .ref*field E " I:" "" " (red.),"
.\}
.el \{\
.	ie \\n([E>0 .ref*field E " In:" "" " (eds),"
.	el .ref*field E " In:" "" " (ed.),"
.\}
..
.de ref*add-G
.ref*field G "" ( )
..
.de ref*add-B
.ie d [E .ref*field B "" "\fI" "" \fP
.el .ref*field B "In:" "\fI" "" \fP
..
.de ref*add-O
.ref*field O .
.ie r [O .nr ref*suppress-period \\n([O
.el .nr ref*suppress-period 1
..
.de ref*add-A
.ref*field A ,
.if r [A .nr ref*suppress-period \\n([A
..
.de ref*add-N
.ref*field N "" "(" ")"
..
.de ref*add-V
.ie d [B .ref*field V , " vol. "
.el .ref*field V ""
..
.de ref*add-S
.ie d [B .ref*field S ""
.el .ref*field S ,
..
.de ref*add-dflt
.ref*field \\$1 ,
..
.de REFREDEF
.mso \\$1
..
.\" First argument is the field letter.
.\" Second argument is the punctuation character to use to separate this field
.\" from the previous field.
.\" Third argument is a string with which to prefix this field.
.\" Fourth argument is a string with which to postfix this field.
.\" Fifth argument is a string to add after the punctuation character supplied
.\" by the next field.
.de ref*field
.if d ref*string \{\
.	ie d ref*post-punct \{\
.		as ref*string "\\$2\\*[ref*post-punct] \"
.		rm ref*post-punct
.	\}
.	el .as ref*string "\\$2 \"
.\}
.as ref*string "\\$3\\*([\\$1\\$4
.if \\n[.$]>4 .ds ref*post-punct "\\$5
.nr ref*suppress-period 0
..
.\" ****************************
.\" ******** module acc ********
.\" ****************************
.\" Accents and special characters.
.ds Q \(lq
.ds U \(rq
.ds - \(em
.\" Characters
.\" The idea of this definition is for the top of the 3 to be at the x-height.
.if !c\[yogh] .char \[yogh] \Z'\v'\w'x'*0-\En[rst]u'\s[\En[.s]*8u/10u]\
\v'\w'3'*0+\En[rst]u'3\s0'\h'\w'\s[\En[.s]*8u/10u]3'u'
.\" Accents
.de acc*over-def
.ds \\$1 \Z'\v'(u;\w'x'*0+\En[rst]-\En[.cht])'\
\h'(u;-\En[skw]+(-\En[.w]-\w'\\$2'/2)+\En[.csk])'\\$2'
..
.de acc*under-def
.ds \\$1 \Z'\v'\En[.cdp]u'\h'(u;-\En[.w]-\w'\\$2'/2)'\\$2'
..
.de acc*slash-def
.ds \\$1 \Z'\h'(u;-\En[.w]-\w'\\$2'/2)'\
\v'(u;\En[.cdp]-\En[.cht]+\En[rst]+\En[rsb]/2)'\\$2'
..
.de acc*prefix-def
.ds \\$1 \Z'\h'(u;\w'x'-\w'\\$2'/2)'\\$2'
..
.acc*prefix-def ' \'
.acc*prefix-def ` \`
.acc*prefix-def ^ ^
.acc*prefix-def , \(ac
.acc*prefix-def : \(ad
.acc*prefix-def ~ ~
.\" improved accent marks
.de AM
.acc*over-def ' \'
.acc*over-def ` \`
.acc*over-def ^ ^
.acc*over-def ~ ~
.acc*over-def : \(ad
.acc*over-def v \(ah
.acc*over-def _ \(a-
.acc*over-def o \(ao
.acc*under-def , \(ac
.acc*under-def . \s[\En[.s]*8u/10u]\v'.2m'.\v'-.2m'\s0
.acc*under-def hook \(ho
.acc*slash-def / /
.char \[hooko] o\\\\*[hook]
.ds q \[hooko]
.ds 3 \[yogh]
.ds D- \(-D\"			Icelandic uppercase eth
.ds d- \(Sd\"			Icelandic lowercase eth
.ds Th \(TP\"			Icelandic uppercase thorn
.ds th \(Tp\"			Icelandic lowercase thorn
.ds 8 \(ss\"			German double s
.ds Ae \(AE\"			AE ligature
.ds ae \(ae\"			ae ligature
.ds Oe \(OE\"			OE ligature
.ds oe \(oe\"			oe ligature
.ds ? \(r?\"			upside down ?
.ds ! \(r!\"			upside down !
..
.\" Make sure that no blank lines creep in at the end of this file.
