#! /usr/bin/perl -w
#
# uni2groff.pl
#
# Convert input in UTF8 encoding to something groff 1.19 or greater
# can understand.  It simply converts all Unicode values >= U+0080
# to the form \[uXXXX].
#
# Usage:
#
#   perl uni2groff.pl < infile > outfile
#
# You need perl 5.6 or greater.

use strict;

binmode(STDIN, ":utf8");

while (<>) {
  s/(\P{InBasicLatin})/sprintf("\\[u%04X]", ord($1))/eg;
  print;
}

# EOF
