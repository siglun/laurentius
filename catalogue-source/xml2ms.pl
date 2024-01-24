#!/usr/bin/perl -w

use strict;

use XML::LibXSLT;
use XML::LibXML;

my $home = './';

my $sheet=$home.'master2roff.xsl';
                 
my $parser = XML::LibXML->new();
my $xslt = XML::LibXSLT->new(); 

my $sourcefile = $ARGV[0];

my $style_doc  = $parser->parse_file($sheet);
my $stylesheet = $xslt->parse_stylesheet($style_doc);
my $source     = $parser->parse_file($sourcefile);
my $results    = $stylesheet->transform($source);
my $doc        = $stylesheet->output_string($results);

my @troffdoc = &preprocess($doc);

binmode(STDOUT, ":utf8");

LINE: while (my $line = shift @troffdoc) {
    next LINE if $line =~ m/^\*.\s*$/;
    next LINE if $line =~ m/\@\@\@\s*Detailed\s+description:/;
    $line =~ s/\.\././g;
    $line =~ s/…/.../g;
    $line =~ s/<\s/</g;
    if($line !~ m/^\./) {
	$line =~ s/ThreeDotsInARow/\\&.../g;
    } else {
	$line =~ s/ThreeDotsInARow/.../g;
    }
    $line =~ s/\[[\s\n]*/[/g;
    $line =~ s/[\n\s]*\]/]/g;
    print "$line\n";
}

sub preprocess {

    my $roff = shift;

    my @content = split (/\n+/,$roff);

    my $text = '';

    my $preserve_space=0;

    my @document=();

    foreach my $line (@content) {

#
#   Start of Display or table
#
        if ($line =~ m/^\.(TS|LD|ID|RD|CD)/) {
            push @document,$text;
            $text='';
            push @document,$line;
            $preserve_space=1;
            next;
        }
#
#   End of Display or table
#

        if ($line =~ m/^\.(DE|TE)/) {
            $preserve_space=0;
            push @document,$line;
            next;
        }

        if ( $text =~ s/(\s+\")[\n\s]*$/$`$1/) {
            $text .= " $line";
	    next;
        }

#
#   Handling of the rest
#
        if($preserve_space) {
            push @document,$line unless $line =~ m/^\s*$/;
            next;
        } else {

            $line =~ s/\s+/ /g;

#
#   1. The line is just an ordinary line of text. We put it in
#      the 'text' buffer.
#


            if($line !~ /^\./) {
		$text = join ' ',$text,$line;
                next;
            } else {

#
#   2. We've found a request or macro
#      We start by emitting the text we've got sofar
#

                if($text =~ m|.+|) {
                    $text =~ s/\s+/ /g;
		    $text =~ s/\.\.\./ThreeDotsInARow/g;
                    $text =~ s/(\w+)[\n\s]*([\)])[\s\n]+/$1$2 /g;
                    $text =~ s/([\w\s]{5,})[\s\n]*([\.\;\:\?\!\,])[\s\n]+/$1$2\n/g;
		    $text =~ s/(\\\(lq)[\n\s]*?(\w+.*)/$1$2/g;
		    $text =~ s/\([\s\n]*(\w+)/\($1/g;
		    $text =~ s/(\\\&)\s*([\.,])/$1$2/g;
		    $text =~ s/(\\fI)\s*(\w+)/$1$2/g;
		    $text =~ s/(\\FK)\s*(\w+)/$1$2/g;

                    my @r = split /\n+/,$text;

                    while(my $l = shift (@r)) {
                        $l =~ s/^\s*//;
                        push @document,$l if $l !~ m/^\s*$/;
                    }
                    $text = '';
                }
#
#     Then we emit the macro itself
#
                push @document,$line;
            }
        }
    }

#
#     We're done, but there might be some stuff left in the text buffer
#

    if($text =~ m|.+|) {
        push @document,$text;
    }

    return @document;

}

