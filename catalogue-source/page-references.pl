#!/usr/bin/perl -w
 
use strict;

my $references = '<?xml version="1.0" encoding="UTF-8" ?>'."\n";
$references .= "<references>\n";
while(my $line = <>) {
    chomp $line;
    my ($type,$id,$twodots,$PN) = split /\s+/,$line,4;
    $references .= "  <reference id=\"".$id."\"\n";
    $references .= "             PN=\"".$PN."\"/>\n";
}
$references .= "</references>\n";
print $references;
