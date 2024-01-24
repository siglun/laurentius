#! /usr/bin/perl -w
#
# groff2uni.pl
#
# Convert groff unicode entities of the form \u[XXXX] back to Unicode.
#
# Usage:
#
#   perl groff2uni.pl < infile > outfile
#
# You need perl 5.6 or greater.

use strict;

binmode STDOUT,"utf8:";
while (<>) {
  s/\\\[u([0-9A-F]{4,6})\]/chr(oct("0x" . $1))/eg;
  print;
}

# EOF
