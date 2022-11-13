#!/usr/bin/perl

#########################
## getIP.pl - Save the IP address of the requester
#########################

use strict 'refs';

$remoteAddress = $ENV{REMOTE_ADDR};

#
# This saves a file on the server that contains just the IP address,
#  just for shits and giggles.
#
open ( OUTFILE, ">homeIP.txt" );
print OUTFILE $remoteAddress;
close OUTFILE;

#
# This file contains an HTML anchor that points to the application
# on my home server.
#
open ( OUTFILE, ">appname.html" );
print OUTFILE "<A HREF=\"http://$remoteAddress/appname\">My Application</A>";
close OUTFILE;

#
# This file has an HTML anchor that points to the same application
# on my home server.  But this time over SSL (port 443)
#
open ( OUTFILE, ">secure_app.html" );
print OUTFILE "<A HREF=\"https://$remoteAddress/appname\">My App(secure)</A>";
close OUTFILE;

#
# This file has an HTML anchor that points to a second application that I use.
#
open ( OUTFILE, ">secondApp.html" );
print OUTFILE "<A HREF=\"http://$remoteAddress/secondApp\">Second App</A>";
close OUTFILE;

#
#  A static web page on the home server
#
open ( OUTFILE, ">page.html" );
print OUTFILE "<A HREF=\"http://$remoteAddress/page.html\">Static Page</A>";
close OUTFILE;
