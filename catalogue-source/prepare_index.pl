#!/usr/bin/perl -w

binmode STDOUT,":utf8";

use strict;

use XML::LibXSLT;
use XML::LibXML;
my $idx_file = $ARGV[0];
my $terms    = $ARGV[1];

die "$0 idx_file term_file\n" unless $idx_file && $terms;

my $parser      = XML::LibXML->new();

my $doc = $parser->parse_file($terms);

open IDX,"<$idx_file" or die "Cannot open $idx_file: @_\n";
binmode IDX,":utf8";

while(my $line = <IDX>) {
    my $regexp = '[MD][he]p?_\d+[abc]?:id\d+';
    if($line =~ m/($regexp)/) {
	my $id = "$1";
	my $text = $doc->findvalue("/terms/term[\@reference='$id']");
	
	if($line =~ s/$regexp\s*/$text/) {
	    print $line;
	}
    } else {
	print $line;
    }
}








