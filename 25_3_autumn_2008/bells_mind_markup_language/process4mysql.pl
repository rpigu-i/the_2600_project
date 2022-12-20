#!/usr/bin/perl -w

# process4mysql.pl -

use strict;

my $scan = shift or die ">>> Need a scan...";
open my $file, '<', $scan or die ">>> Can't open scan: $!";

while (<$file>) {
	chomp;
	my @array = split(/ - /, $_);
	$array[0] =~ /^(\d{3})-(\d{3})-(\d{4})/;
	my $npa = $1;
	my $nxx = $2;
	my $ext = $3;
	$array[1] =~ s/\'/\\'/g;
	print "INSERT INTO phonebook (`npa`, `nxx`, `ext`, `description`, `type`) VALUES ('$npa', '$nxx', '$ext', '$array[1]', '$scan')\;\n";
}

close $file;
