i#!/usr/bin/perl -w
#
# A simple program to open a TCP port. Useful for
# testing SYN packet issues on state-like firewalls.
#
# http://www.assdingos.com/grass/
# 
# Shout outs: Cat5, Rijendaly Llama, chix0r, alx0r,
#             exial, stormdragon, lucid_fox, 
#             Deathstroke, Harkonen, daverb and
#             eXoDuS (YNBABWARL!)
#
# Some code used from snacktime.pl
# http://www.planb-security.net/wp/snacktime.html
# (C) Tod Beardsley
#
# Copyright (C) Gr@ve_Rose
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#

use warnings;
use strict;
use Getopt::Std;
use IO::Socket::INET;

# IPv6 Support - README
# To get IPv6 support you will need to install two 
# additional Perl modules: Socket6 and IO-Socket-INET6
# First, download each package from CPAN:
# Socket6 -> http://search.cpan.org/CPAN/authors/id/U/UM/UMEMOTO/Socket6-0.17.tar.gz
# INET6   -> http://search.cpan.org/CPAN/authors/id/M/MO/MONDEJAR/IO-Socket-INET6-2.51.tar.gz
# Once downloaded, uncompress each file and go into
# the new directories. Run the command (as r00t):
# perl ./Makefile.PL && make && make install
# in each directory to install the modules. You need to
# install Socket6 first. 
# Finally, uncomment the line below and enjoy.
use IO::Socket::INET6;

$| = 1 ; # Get rid of the buffer and dump to STDOUT

my %options;
getopts('m:t:p:s:x:',\%options) || usage();

# Are we asking for the man page? If so, stop here and go there.
if ($options{m}) {

	man();
	die;
}

# Do we have a Target IP?
if (not $options{t}) {
	print "\r\n";
	print "         [*************ERROR**************]";
	print "\n";
	print "     --==[You forgot the target IP Address]==--";
	print "\n";
	print "         [*************ERROR**************]";
	print "\r\n";
	usage();
	die;
}

# Do we have a Target Port?
if (not $options{p}) {
	print "\r\n";
	print "         [**********ERROR***********]";
	print "\n";
	print "     --==[You forgot the target Port]==-";
	print "\n";
	print "         [**********ERROR***********]";
	print "\r\n";
	usage();
	die;
}

# Do we have a Local Source Port?
if (not $options{s}) {
	print "\r\n";
	print "         [**********ERROR***********]";
	print "\n";
	print "     --==[You forgot the source Port]==-";
	print "\n";
	print "         [**********ERROR***********]";
	print "\r\n";
	usage();
	die;
}


# Default to IPv4 or if specified
if (not $options{x} or $options{x} == "4") {

	my $socket = IO::Socket::INET -> new(PeerAddr => $options{t}, PeerPort => $options{p}, LocalPort => $options{s}, Proto => 'tcp');

	my $gigo = "\r\n"; # A basic [ENTER] button to send if you want.
                   # See the blurb below for usage of this variable
                   # Go ahead and modify this for a specific protcol
		   # like HELO (port 25), or an HTTP GET request.
	# If you would like to send a basic [ENTER] (Or whatever you've created)
	# to the socket once connected, replace:
	# print $socket
	# listed below with:
	# print $socket $gigo

	printf "\r\nAttempting to connect... (IPv4)\r\n^C sends a FIN packet whenever you are ready to close the connection.\r\n \r\n";

	printf $socket || die "There was an error in the connection. Check the following:\r\n- Closed/filtered port?\r\n- If you are using the same source port, the TCP connection may not have ended. Send a FIN/RST or wait until your TCP End Timeout has been reached.\r\n \r\n";

	while (<$socket>) {

		print $_;
	}

}


# If IPv6 is explicitly defined in the command variable...
if ($options{x} == "6") {

	my $socket = IO::Socket::INET6 -> new(PeerAddr => $options{t}, PeerPort => $options{p}, LocalPort => $options{s}, Proto => 'tcp');

	my $gigo = "\r\n"; # See note above for $gigo usage...

	printf "\r\nAttempting to connect... (IPv6)\r\n^C sends a FIN packet whenever you are ready to close the connection.\r\n \r\n";

	printf $socket || die "There was an error in the connection. Check the following:\r\n- Closed/filtered port?\r\n- If you are using the same source port, the TCP connection may not have ended. Send a FIN/RST or wait until your TCP End Timeout has been reached.\r\n \r\n";

	while (<$socket>) {

		print $_;
	}

}

sub usage {

	die <<EOH;

Grave_Rose\'s Atomically Small SYN - A small SYN sending program
                         Version 0.5

Usage: grass.pl -t [IP_to_connect_to] -p [DST_Port] -s [SRC_Port] (-x [4][6]) (-man)

-t MUST be present (Who are you sending the packet to?)
-p MUST be present (What port are you opening?)
-s MUST be present (Why would you want a dynamic source port?)
-x MAY be present - Use "-x 6" for IPv6 instead of IPv4
		    (Defaults to IPv4 if not present)
-man - Shows the mini-man page for further information

      If you\'re seeing this message, you didn\'t get the memo.

There is additional information in the source of this program so if
 you have any questions, look in the source before bugging me about
  anything. All you have to do, is open grass.pl in your favourite
           text editor and look at some of the comments.
                          Grave_Rose


EOH
}

sub man {

	die <<EOM;

G.R.A.S.S. Mini-Man Page

NAME
	grass.pl - A small Perl SYN program

SYNOPSIS
	grass.pl -t [IP_to_connect_to] -p [DST_Port] -s [SRC_Port] (-x [4][6]) (-man)

DESCRIPTION
	grass.pl is a program intended to assist in troubleshooting network related issues
	specifically with SYN and Source-Port troubles. You can use grass.pl to either act
	as a "door-jam" for a SYN connection by starting it first or use it once an established
	connection is already in place and you want to cause an effect from the same source 
	port as the previous connection.

OPTIONS
	-t Specifies the Target IP address. This value *MUST* be present and can be either
	IPv4 (Default) or IPv6 (See -x below).
	
	-p Specifies the Target Port. This value *MUST* be present.
	
	-s Specifies the Source Port. This value *MUST* be present.
	
	-x Select IPv4 (Default or -x4) or IPv6 (-x6). For IPv6 to work, you *MUST* have the
	Socket6 and IO::Socket::INET6 Perl Modules installed as well as a capable IPv6-enabled 
        interface.
	
RETURN VALUES
	If a successful TCP connection is made, the IO::Socket::INET(6) will return a GLOB
	from the connection. In the event the connection is unsuccessful, an error message
	will be printed. If one of the three *MUST* options are missing, an error message
	will be printed and will tell you which one you are missing.
	
EXAMPLES
	Open port 80 on 10.11.12.13 from a source port of 31377:
	./grass.pl -t 10.11.12.13 -p 80 -s 31337
	
	Open port 110 on fec0:c0ff:ee01::1 from a source port of 5678:
	./grass.pl -t fec0:c0ff:ee01::1 -p 110 -s 5678 -x 6
	
SECURITY NOTES
	As long as you have access to Perl, this program has the potential to be a complete
	SYN DoS program. It is *STRONGLY* suggested that you use this program with restraint
	as basic "while" looping can change the program from "Happy Troubleshooting Tool" to
	"Evil Script O' Death". Just as a hammer can be a tool or a weapon, I designed this
	to be a tool and not a weapon. If this program ends up DoS-ing your network, take
	action against the person who did this and not against me.
	
BUGS
	Using the -m(an) switch... You can type anything after the letter "m" and you will get
	this mini-man page. Using -m by itself does nothing though.
	Yes, even: ./grass.pl -man am I drunk
	
EOM
}
