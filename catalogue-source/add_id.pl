#!/usr/bin/perl

use strict;

use XML::LibXSLT;
use XML::LibXML;

my $sheet       = '/home/sigge/WWW/2007/msdescription/catalogue-source/add-id.xsl';
my $records     = $ARGV[0];
my $destination = $ARGV[1];

exit() unless $records && $destination;
                 
my $parser      = XML::LibXML->new();
my $xslt        = XML::LibXSLT->new(); 

my $style_doc   = $parser->parse_file($sheet);
my $stylesheet  = $xslt->parse_stylesheet($style_doc);


while(my $vol = <$records/*xml> ) {
    next unless $vol =~ m/Dep/ || $vol =~ m/Mh/;
    print $vol . "\n";
    my $source = $parser->parse_file($vol);
    my $doc = '';
    my $results = $stylesheet->transform($source);
    $doc=$stylesheet->output_string($results);
    if($doc) {
	my $dest = $vol;
	$dest =~ s/$records/$destination/;
	$dest =~ s|//|/|g;
	print "$dest\n";
	open(DEST,">$dest") or die "Cannot open $dest\n";
	binmode DEST,":utf8";
	print DEST $doc;
	close DEST;
    }
}







