#TDM 2005
#
#
my $x=0; #used on the FORM FILL Area on $sizeofharvestedURls index
my $y=0; #used to index thru FORMS on page
my $q=0;
my $z=0; #Level I index
my $a=0;
my $b=0;
my $c=0;
my $d=0;
my $e=0; #Level II index
my $p = HTML::LinkExtor->new(\&callback);
my $input = 0; #Used to input data from files
my @harvestedULs = ();
my $sizofharvestedURLs = 0;
my $sizeofinput = 0;
my $url = "";  #Level I
my $url2 = ""; #Level II
my @links = ();#stripped links array
my $sizeoflinks = 0;
my $counter = 0;
$file = "searchdata.txt"; #DOT.COMS from searchdata.txt file

#----------------------------- Set up Agent ------------------------------------
require LWP::UserAgent;
use HTML::LinkExtor;
use URI::URL;

$ua = new LWP::UserAgent;
      $ua->timeout(5); #not sure of this number. Ex. code had 5, I put in 5
      $ua->agent('Mozilla/4.75'); 
#     $ua->proxy(http => 'http://127.0.0.1:8118'); # TOR TOR TOR
      $ua->from('www.xxxxx.com');
      
#----------------Load URL's array with links --------------------

print "\n\n******** Loading URL's *******\n\n";
if (open(A, "$file") == undef){
    return( print "\n\n\nSHIT !!! Cannot open the file :( \n\n\n");
    exit(-1);
} #endif()
while(<A>){
      $input=<A>;
      push(@harvestedURLs, $input);
}#endwhile()
close(A);
$sizeofharvestedURLs = $#harvestedURLs;
print "Seed URL's = $sizeofharvestedURLs\n\n";
sleep(2); #used to let array to settle in

########################### Begin Spider ###############################

print "\n\n Begin Spider run .....\n\n";
while($x <= $sizeofharvestedURLs){#aa  #Loop for harvestedURLs
      $url = $harvestedURLs[$x];    #uses $x for indexing
      print "-- Home Page -- Level I -- $url\n\n";
      sleep(1); # used to sow down for TOR.
      #$counter++;
      #print "$counter\n";
      $req = new HTTP::Request GET => $harvestedURLs[$x];
      $response = $ua->request($req);
      my $base = $response->base;
      
      if($response->is_success) {#bb
          sleep(2); # Used to slow down for TOR
	 $p->parse($response->content);      
         

#                  **  LINK STRIPPING **

	 @links = map { $_ = url($_, $base)->abs; } @links;
         #print "@links"; # test point for link stripping
	 $sizeoflinks = $#links;
	 
#                  ** End LINK STRIPPING  **	

          # Here is where you set up for a run on home page #
	 
  }#bb# 
  
#****************** LVL 2 -  BEGIN *********************************************
  
  while($c <= $sizeoflinks ){#xxx
       $url2 = $links[$c++];      
       print "$url2\n";
       print "Level 2 STRIPPED URL\n\n";
       sleep(10); #used to slow down for viewing the spider operation
       
                 # Enter into level 3 #
#                      ***
                  # Exiting Level 3 #
              
       # Here is where you set up for a run on Level 2 #  
       
  }#xxx Exit Level 2
#******************** LVL 2 -  END *********************************************

  
 $c = 0; #reset level 2 $links variable
 $x++; # Used on $harvestedURLs[$x]
 @links = ""; # makes sure that @array is empty
}#aa  Exit Level 1
######################### END Spider ###########################################

#----------------------Link Stripping Sub-Routine-------------------------------
  sub callback { #999
     my($tag, %attr) = @_;
     return if $tag ne 'a';  # Tag to strip <a>, <img>, ....etc
     push(@links, values %attr);
     
} #999 End sub callback
#-------------------------------------------------------------------------------
# TDM 2005
# Updated Feb. 01, 2008 --  Triad
# Update Apr.29.2010 - Triad
# Updated June 19 2010 - Triad
################################################################################

