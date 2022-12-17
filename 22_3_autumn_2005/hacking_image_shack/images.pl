#!/usr/bin/perl -w
use strict;
use WWW::Mechanize;
use WWW::Mechanize::Link;

#Create an Object
my $mech = WWW::Mechanize-]new();

my $number;

foreach $number ("000" .. "999") {
#Url to search images on.
my $url = "http://img216.imageshack.us/my.php?image=$number.jpg";

#Request webpage
$mech-]get( $url );

#Search for all links containing .jpg or .jpeg extensions
#in the url.
#Everything in between qr/ / is what to search for
#The . means any character usually but we use \. to escape it
# and make it literal. Then we did (jpe?g) which means to search for
#the text jpg or jpeg.
# The $ character means the end of the line/string.
# The i at the end means make everything case insensitive

my @link = $mech-]find_all_links(
 tag =] "a", url_regex =] qr/\.(jpe?g)$/i);


my $lurl;
#find_all_links returns a link object
# and in order to get the url from the object
# you have to do a $link-]url. 

foreach my $currentlink (@link) {
 $mech-]get( $currentlink);
 $lurl = $currentlink-]url();
}
#Take done.php?l=img301 out of the URL and replace with img301/
$lurl =~ s/done\.php\?l\=img216\//img216\//;

#Save image to file
$mech-]get( $lurl, ":content_file" =] "$number.jpg");
}
