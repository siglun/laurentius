#
# Makefile for S:t Laurentius wannabe printed catalogue
# $Id: Makefile,v 1.6 2007/05/26 13:14:56 sigge Exp sigge $
#

.SUFFIXES: .ms .ps .pdf .xml

default: catalogue.ps

# make segments_done in order to create a pdf per manuscript

TRANSFORM = ./xml2ms.pl
XDIR      = ../cleaned

GROFF=groff -U -Tps -kt -Kutf8 -M/home/sigge/documents/tmac  -ma4 -P-pa4 -mgs

MS = Mh_1.ms Mh_2.ms Mh_3.ms Mh_4.ms Mh_5.ms Mh_6.ms Mh_7.ms Mh_8.ms\
	Mh_9.ms Mh_10.ms Mh_11.ms Mh_12.ms Mh_13.ms Mh_14.ms Mh_15.ms\
	Mh_16.ms Mh_17.ms Mh_18.ms Mh_19.ms Mh_20.ms Mh_21.ms\
	Mh_22.ms Mh_23.ms Mh_24.ms Mh_25.ms Mh_26.ms Mh_27.ms\
	Mh_28.ms Mh_29.ms Mh_30.ms Mh_31.ms Mh_32.ms Mh_32a.ms\
	Mh_32b.ms Mh_33.ms Mh_34.ms Mh_35.ms Mh_36.ms Mh_37.ms\
	Mh_38.ms Mh_39.ms Mh_40.ms Mh_41.ms Mh_42.ms Mh_43.ms\
	Mh_43a.ms Mh_43b.ms Mh_44.ms Mh_45.ms Mh_46.ms Mh_47.ms\
	Mh_48.ms Mh_49.ms Mh_50.ms Mh_51.ms Mh_52.ms Mh_53.ms\
	Mh_54.ms Mh_55.ms Mh_56.ms Mh_57.ms Mh_58.ms Mh_59.ms\
	Mh_60.ms Mh_61.ms Mh_62.ms Mh_63.ms Mh_64.ms Mh_65.ms\
	Dep_1.ms

$(MS): %.ms : $(XDIR)/%.xml
	$(TRANSFORM) $<  > $@


doc.ms : 
	soelim two_col.ms $(MS) document.ms > doc.ms

indexing_done : 
	$(GROFF) parameters.ms smallcaps.ms doc.ms > /dev/null
#	recode latin1..utf8 master-index.txt.in
	./prepare_index.pl master-index.txt.in idx_summary.xml > master-index.txt
#	./groff2uni.pl master-index.txt.tmp > master-index.txt
	export LC_COLLATE=sv_SE.UTF-8;./make_lists.pl
	touch indexing_done; rm tocinfo.text

catalogue.ps :
	$(GROFF) parameters.ms smallcaps.ms doc.ms > catalogue.ps
#	recode latin1..utf8 master-index.txt.in
	./prepare_index.pl master-index.txt.in idx_summary.xml > master-index.txt
#	./groff2uni.pl master-index.txt.tmp > master-index.txt
	export LC_COLLATE=sv_SE.UTF-8;./make_lists.pl

segments_done:
	./segment.pl tocinfo.text
	touch segments_done

clean :
	rm -f indexing_done catalogue.ps doc.ms tocinfo.text \
	segments_done *.pdf

realclean :
	rm -f indexing_done catalogue.ps doc.ms *~ $(MS)

segments_done: tocinfo.text
tocinfo.text: catalogue.ps
catalogue.ps: parameters.ms doc.ms indexing_done
indexing_done: parameters.ms doc.ms
doc.ms: two_col.ms document.ms $(MS)
Mh_1.ms: $(XDIR)/Mh_1.xml
Mh_2.ms: $(XDIR)/Mh_2.xml
Mh_3.ms: $(XDIR)/Mh_3.xml
Mh_4.ms: $(XDIR)/Mh_4.xml
Mh_5.ms: $(XDIR)/Mh_5.xml
Mh_6.ms: $(XDIR)/Mh_6.xml
Mh_7.ms: $(XDIR)/Mh_7.xml
Mh_8.ms: $(XDIR)/Mh_8.xml
Mh_9.ms: $(XDIR)/Mh_9.xml
Mh_10.ms: $(XDIR)/Mh_10.xml
Mh_11.ms: $(XDIR)/Mh_11.xml
Mh_12.ms: $(XDIR)/Mh_12.xml
Mh_13.ms: $(XDIR)/Mh_13.xml
Mh_14.ms: $(XDIR)/Mh_14.xml
Mh_15.ms: $(XDIR)/Mh_15.xml
Mh_16.ms: $(XDIR)/Mh_16.xml
Mh_17.ms: $(XDIR)/Mh_17.xml
Mh_18.ms: $(XDIR)/Mh_18.xml
Mh_19.ms: $(XDIR)/Mh_19.xml
Mh_20.ms: $(XDIR)/Mh_20.xml
Mh_21.ms: $(XDIR)/Mh_21.xml
Mh_22.ms: $(XDIR)/Mh_22.xml
Mh_23.ms: $(XDIR)/Mh_23.xml
Mh_24.ms: $(XDIR)/Mh_24.xml
Mh_25.ms: $(XDIR)/Mh_25.xml
Mh_26.ms: $(XDIR)/Mh_26.xml
Mh_27.ms: $(XDIR)/Mh_27.xml
Mh_28.ms: $(XDIR)/Mh_28.xml
Mh_29.ms: $(XDIR)/Mh_29.xml
Mh_30.ms: $(XDIR)/Mh_30.xml
Mh_31.ms: $(XDIR)/Mh_31.xml
Mh_32.ms: $(XDIR)/Mh_32.xml
Mh_32a.ms: $(XDIR)/Mh_32a.xml
Mh_32b.ms: $(XDIR)/Mh_32b.xml
Mh_33.ms: $(XDIR)/Mh_33.xml
Mh_34.ms: $(XDIR)/Mh_34.xml
Mh_35.ms: $(XDIR)/Mh_35.xml
Mh_36.ms: $(XDIR)/Mh_36.xml
Mh_37.ms: $(XDIR)/Mh_37.xml
Mh_38.ms: $(XDIR)/Mh_38.xml
Mh_39.ms: $(XDIR)/Mh_39.xml
Mh_40.ms: $(XDIR)/Mh_40.xml
Mh_41.ms: $(XDIR)/Mh_41.xml
Mh_42.ms: $(XDIR)/Mh_42.xml
Mh_43.ms: $(XDIR)/Mh_43.xml
Mh_43a.ms: $(XDIR)/Mh_43a.xml
Mh_43b.ms: $(XDIR)/Mh_43b.xml
Mh_44.ms: $(XDIR)/Mh_44.xml
Mh_45.ms: $(XDIR)/Mh_45.xml
Mh_46.ms: $(XDIR)/Mh_46.xml
Mh_47.ms: $(XDIR)/Mh_47.xml
Mh_48.ms: $(XDIR)/Mh_48.xml
Mh_49.ms: $(XDIR)/Mh_49.xml
Mh_50.ms: $(XDIR)/Mh_50.xml
Mh_51.ms: $(XDIR)/Mh_51.xml
Mh_52.ms: $(XDIR)/Mh_52.xml
Mh_53.ms: $(XDIR)/Mh_53.xml
Mh_54.ms: $(XDIR)/Mh_54.xml
Mh_55.ms: $(XDIR)/Mh_55.xml
Mh_56.ms: $(XDIR)/Mh_56.xml
Mh_57.ms: $(XDIR)/Mh_57.xml
Mh_58.ms: $(XDIR)/Mh_58.xml
Mh_59.ms: $(XDIR)/Mh_59.xml
Mh_60.ms: $(XDIR)/Mh_60.xml
Mh_61.ms: $(XDIR)/Mh_61.xml
Mh_62.ms: $(XDIR)/Mh_62.xml
Mh_63.ms: $(XDIR)/Mh_63.xml
Mh_64.ms: $(XDIR)/Mh_64.xml
Mh_65.ms: $(XDIR)/Mh_65.xml
Dep_1.ms: $(XDIR)/Dep_1.xml

#
# $Log: Makefile,v $
# Revision 1.6  2007/05/26 13:14:56  sigge
# Ensuring that correct locale is set for sorting
#
# Revision 1.5  2007/05/19 19:19:51  sigge
# More clean up
#
# Revision 1.4  2007/05/19 19:17:21  sigge
# cleaning up
#
# Revision 1.3  2007/05/19 19:16:13  sigge
# Removed the external unicode "recoder"
#
# Revision 1.2  2003/12/09 08:59:40  sigge
# The Makefile now rebuilds all the segment PDFs as well. Everything in
# one go!
#
# Revision 1.1  2003/12/09 08:40:28  sigge
# Initial revision
#
#
#
