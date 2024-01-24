#!/usr/bin/perl -w

use strict;

my $temp="temp".$$.".text";
my $titind= "titleindex.ms";
my $authind= "authorindex.ms";
my $placeind= "places.ms";
my $othernames= "other_names.ms";
my $persons= "person_names.ms";
my $bydate= "mssbydate.ms";
my $bylang= "mssbylang.ms";
my $byplace= "mssbyplace.ms";

my $fix_lists = './process-list.pl  master-index.txt | ';

my $cmd = $fix_lists .'grep \'title\' |sed \'s/title://\'|sort -u|';
open(TIT,"$cmd");
binmode TIT, ":utf8";
my %titles=();
my @titlist=();
open TEMP,"|sort -u > $temp";
binmode TEMP,":utf8";
while(my $t=<TIT>) {
    chomp $t;
    my ($tit,$rest) = split(/\#\#\#/,$t);
    my $title=$tit;
    $title =~ s/[\.\,]\s*$//;
    next unless $rest;
    $tit = lc($tit);
    my $origp='';
    if($rest =~ s/\s*--\s*([^-]*?)\s*--s*//) {
	$origp=$1;
    }
    $rest =~ m/\.\.\.\s*(\d+)\s*$/;
    my $p = $1;
    if($titles{$tit}) {
	$p .= " ($origp)" if $origp;
        $titles{$tit}=join ', ',$titles{$tit},$p;
    } else {
	$title .= " $p ($origp)" if $origp;
        $titles{$tit}=$title;
	print TEMP "$tit\n";
    }
}
close TIT;
close TEMP;

open(TIT,"<$temp") or die "Cannot open $temp\n";
binmode TIT,":utf8";
open(TITIND,">$titind") or die "Cannot open $temp\n";
binmode TITIND,":utf8";
my $lastfirst='qwerty';
while(my $t=<TIT>) {
    chomp $t;
    my $tit=$titles{$t};
    $tit =~ s/\s*\.\.\.\s*/, /;
    $tit =~ s/_/ /g;
    print TITIND ".XP\n";
    print TITIND ".na\n";
    my ($myfirst,$rest) = split /\s+/,$tit,2;
#    if ( $myfirst eq $lastfirst) {
    if (0) {
	print TITIND '\(em'."\n$rest\n";
    } else {
	print TITIND $tit."\n";
    }
    print TITIND ".ad\n";
    $lastfirst=$myfirst;
}

close TEMP;
unlink $temp;

$cmd = $fix_lists . 'grep \'^author\' |sed \'s/author://\'|sort -u|';

open(AUTH,"$cmd");
binmode AUTH,"utf8";
my %allauthors=();
while(my $auth=<AUTH>) {
    chomp $auth;
    if(	my ($author,$page) = split(/\s*\.\.\.\s*/,$auth)) {
	my $a = $author;
	$a = lc($a);
	if ($allauthors{$a}) {
	    $allauthors{$a} .= ', '.$page;
	} else {
	    $allauthors{$a} = join '%',$author,$page;
	}
    }
}

close AUTH;

open (TEMP ,"| sort > $temp");
binmode TEMP,":utf8";
while( my ($key,$val) = each %allauthors ) {
    print TEMP "$key\n";
}

close TEMP;
open (TEMP ,"<$temp");
binmode TEMP,":utf8";
open (AUTHIND,">$authind");
binmode AUTHIND,":utf8";
while(my $auth=<TEMP>) {
    chomp $auth;
    my ($author,$pages) = split /%/,$allauthors{$auth};
    my @pages = split /\s*,\s*/,$pages;
    print AUTHIND ".XP\n$author ".join(', ', sort { $a <=> $b } @pages)."\n";
}
close TEMP;
unlink $temp;

$cmd = $fix_lists . 'grep \'^person:\' |sed \'s/person://\'|sort -u|';
open(NAMES,$cmd);
binmode NAMES,":utf8";
my %allpersons=();
while(my $pers=<NAMES>) {
#    print $pers;
    chomp $pers;
    if(	my ($pers,$page) = split(/\s*\.\.\.\s*/,$pers)) {
	my $a = $pers;
	$a = lc($a);
	if ($allpersons{$a}) {
	    $allpersons{$a} .= ', '.$page;
	} else {
	    $allpersons{$a} = join '%',$pers,$page;
	}
    }
}

close NAMES;

open (TEMP ,"| sort > $temp");
binmode TEMP,":utf8";
while( my ($key,$val) = each %allpersons ) {
    print TEMP "$key\n";
}

close TEMP;
open (TEMP ,"<$temp");
binmode TEMP,":utf8";
open (PNAMES,">$persons");
binmode PNAMES,":utf8";
while(my $auth=<TEMP>) {
    chomp $auth;
    my ($author,$pages) = split /%/,$allpersons{$auth};
    my @pages = split /\s*,\s*/,$pages;
    print PNAMES ".XP\n$author ".join(', ', sort { $a <=> $b } @pages)."\n";
}
close TEMP;
close PNAMES;
unlink $temp;

$cmd = $fix_lists . 'grep \'^place:\' |sed \'s/place://\'|sort -u|';

open(PLACENAMES,">$placeind");
binmode PLACENAMES,":utf8";
open(PLACES,$cmd);
binmode PLACES,":utf8";

while(my $p=<PLACES>) {
    if($p =~ s/\s*\.\.\.\s*/, /) {
	print PLACENAMES ".XP\n";
	print PLACENAMES $p;
    }
}

close PLACES;
close PLACENAMES;

$cmd = $fix_lists . 'grep \'^name\' |sed \'s/name://\'|sort -u|';
open(NAMES,$cmd);
binmode NAMES,"utf8";
open(ONAMES,">$othernames");
binmode ONAMES,":utf8";

while(my $name=<NAMES>) {
    $name =~ s/\s*\.\.\.\s*/, /;
    print ONAMES ".XP\n";
    print ONAMES $name;
}

close NAMES;
close ONAMES;

$cmd = $fix_lists . 'grep \'^publ-date\' |sed \'s/publ-date://\'|sort -u|';

open(DATES,$cmd);
binmode DATES,"utf8";
open(BYDATE,">$bydate");
binmode BYDATE,":utf8";

while(my $d=<DATES>) {
    chomp($d);
    $d =~ s/\s*\.\.\.\s*/#/g;
    $d =~ s/#\(/ /g;
    $d =~ s/\)#/#/g;
    my ($inexact,$date,$ms,$page) = split /#/,$d;
    if($date&&$ms&&$page) {
	$date =~ s/(\d\d\d\d)(.\d\d)+/$1/g;
	print BYDATE "T{\n.na\n$date\nT}#$ms#$page\n";
	print BYDATE "_\n";
    }
}

close DATES;
close BYDATE;

$cmd = $fix_lists . 'grep \'language\' |sed \'s/language://\'|sort -u|';
open(LANGS,$cmd);
binmode LANGS,"utf8";
open(BYLANG,">$bylang");
binmode BYLANG,":utf8";

while(my $lang=<LANGS>) {
    chomp $lang;
    $lang =~ s/\s*\.\.\.\s*/#/g;
    print BYLANG "$lang\n";
    print BYLANG "_\n";
}

close LANGS;
close BYLANG;

$cmd = $fix_lists . 'grep \'^publ-place\' |sed \'s/publ-place://\'|sort -u|';

open(PLACE,$cmd);
binmode PLACE,"utf8";
open(BYPLACE,">$byplace");
binmode BYPLACE,":utf8";

while(my $p=<PLACE>) {
    chomp($p);
    $p =~ s/\s*\.\.\.\s*/#/g;
    my ($place,$ms,$page) = split /#/,$p;
    $place =~ s/[\.,;]$//;
    if($place&&$ms&&$page) {
	print BYPLACE "T{\n.na\n$place\nT}#$ms#$page\n";
	print BYPLACE "_\n";
    }
}

close PLACE;
close BYPLACE

# End
