#!/usr/bin/perl

#########################
## setIP.pl - requests a page from a website and just exits.
#########################

use strict 'refs';
use LWP::Simple;

my ($content);
my $linkURL = "http://<your external site here>/cgi-bin/getIP.pl";

$content = get ($linkURL);
