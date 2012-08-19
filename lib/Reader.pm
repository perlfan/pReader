package Reader;

use Reader::Logger;
#use Reader::Protocol::HTTP;
use LWP;

my $ua = new LWP::UserAgent;
$ua->agent('firefox');
my $log = new Reader::Logger;
1;
