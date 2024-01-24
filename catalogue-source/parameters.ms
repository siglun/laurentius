.fam K 
.\"BA
.special KR KI S
.nr CINDENT 0c
.nr CINDELTA 0.5c
.nr THICK 0.05c
.de thickline
\D'P 0 -\\n[THICK]u \\n[HEADLEN]u 0 0 \\n[THICK]u'\f(HB
.na
.hy 0
..
.de thinline
.hy 1
.br
\Z'\u\D'l \\n[HEADLEN]u 0''
.ad
..
.nr 2COL 0
.\"als above thickline
.\"als below thinline
.de emptymacro
..
.als above emptymacro
.als below emptymacro
.als print-index-entry emptymacro
.ie (\n[2COL]) \{\
.	nr BIGPS 10
.	nr BIGVS 12
.	nr SMALLPS 9
.	nr SMALLVS 11
.	nr PI 0.5c
.	nr PO 3.5c
.	po \n[PO]u
.	nr LL 14c
.	nr HEADLEN 6.5c
.\}
.el \{\
.	nr BIGPS 11
.	nr BIGVS 13
.	nr SMALLPS 9
.	nr SMALLVS 11
.	nr PI 0.5c
.	nr PO 3.5c
.	nr POodd 3.5c
.	nr POeven 4.5c
.	nr LL 13.0c
.	nr HEADLEN \n[LL]u
.\}
.nr HM 3.0c
.nr FM 3.0c
.nr PL 29.7c
.ds obook "Lund University Library
.ds ebook "Medieval Manuscript Catalogue
.de small
.   nr VS \n[SMALLVS]
.   nr PS \n[SMALLPS]
..
.de segm
.ie !d segment1 .ds segment1 \\$*
..
.de chapterBT
.outhead
..
.de segmentBT
.if !d segment1 .ds segment1 \\*[segment]
.ie d from .ds chapfol \\*[from]
.el .ds chapfol \\*[segment1]
.ie d to .as chapfol \\(en\\*[to]
.el \{\
.	if !'\\*[segment1]'\\*[segment]' .as chapfol \\(en\\*[segment]
.\}
.ds chapter \\*[chapfol]
.outhead
.rm segment1
.rm chapfol
.rm from
.rm to
..
.so headers.ms
.open TOCINFO tocinfo.text
.open HEADER headers.ms
.als BT segmentBT
.de outhead
.ie d HS_START \{\
.	write HEADER ".ds pg*OH\\n[PN]	
.	write HEADER ".ds pg*EH\\n[PN]  
.	write TOCINFO "\\*[segment] ... \\n[PN]
.\}
.el \{\
.	write HEADER ".ds pg*OH\\n[PN] '\\s10\\*[chapter]'\\*[obook]'\\n[PN]'
.	write HEADER ".ds pg*EH\\n[PN] '\\s10\\n[PN]'\\fI\\*[ebook]\\fR'\\*[chapter]'
.\}
.ie o .nr PO \\n[POeven]
.el .nr PO \\n[POodd]
.if d HS_START \{\
.	rm HS_START
.	tl ''\\s10\\n[PN]''
.\}
..
.de PT
.ie o .tl \\*[pg*OH\\n[PN]]
.el .tl \\*[pg*EH\\n[PN]]
..
.de big
.nr VS \n[BIGVS]
.nr PS \n[BIGPS]
..
.big
.open INDEX master-index.txt.in
.
.de begin-index
.box index-terms
.ev index
.evc 0
.in 0
.nf
.hy 0
..
.
.de end-index
.br
.ev
.box
.asciify index-terms
.index-terms
.chop index-terms
.writec INDEX \\$0:
.\"writem INDEX index-terms
.write INDEX "\\$* ... \\n[PN]
.rm index-terms
..
.
.als title begin-index
.als /title end-index
.
.de title-index
.write INDEX "/title:\\$* ... \\n[PN]
..
.
.als person begin-index
.als /person end-index
.de person-index
.write INDEX "person:\\$* ... \\n[PN]
..
.
.als place begin-index
.als /place end-index
.
.als name begin-index
.als /name end-index
.
.als author begin-index
.als /author end-index
.
.de author-index
.write INDEX "author:\\$* ... \\n[PN]
..
.
.als language begin-index
.als /language end-index
.
.als publ-date begin-index
.als /publ-date end-index
.
.als publ-place begin-index
.als /publ-place end-index
.hw medel-tids-hand-skrift
