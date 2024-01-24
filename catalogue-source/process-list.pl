#!/usr/bin/perl

my @categories = ('author',
		  'language',
		  'name',
		  'person',
		  'publ-date',
		  'publ-place',
		  'title');

my $cats = join(' ',@categories);
my $element = "";

while(my $line = <>) {
    chomp $line;
    next if($line =~ m/^\s*$/);
    $line =~ s/^\/?([\w\-]+?)([\s:])/$1$2/;
    my $word = $1;
    if( $word && $cats =~ m/$word/ ) {
	print "$element\n" if $element;
	$element = $line;
    } else {
	$element = $element . ' ' . $line;
    }
}
