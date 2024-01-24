#!/usr/bin/perl

#
# Creates individual PDF files for each manuscript
# $Id: segment.pl,v 1.1 2003/12/09 08:40:28 sigge Exp $
#

my $groff='groff -U -Tps -kt -Kutf8 -M/home/sigge/documents/tmac  -ma4 -P-pa4 -mgs ';


my $previous_page = '';
my $previous_ms   = '';
my @seg_list = ();
while( my $line = <> ) {
    chomp $line;
    my ($current_ms,$current_page) = split /\s*\.\.\.\s*/,$line;
    $current_ms =~ s/\s/_/;
    if($previous_page) {
	push @seg_list, "$previous_ms:$previous_page-".($current_page-1);
    }
    $previous_page = $current_page;
    $previous_ms = $current_ms;
}

foreach my $seg (@seg_list) {

    my ($ms,$n) = split /:/,$seg;

    system "$groff -o $n parameters.ms smallcaps.ms doc.ms > /dev/null";
    system "$groff -o $n parameters.ms smallcaps.ms doc.ms > $ms.ps";
    system "ps2pdf $ms.ps";
    system "rm $ms.ps"

}
