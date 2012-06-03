#
#===============================================================================
#
#         FILE: http.t
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
#      COMPANY: 
#      VERSION: 1.0
#      CREATED: 06/03/2012 01:15:58 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Data::Dumper;

use Test::More tests => 1;                      # last test to print

BEGIN{
    use_ok('Reader::Protocol::HTTP');
}

my $b = Reader::Protocol::HTTP->new();
is( $b->host, '127.0.0.0','test default host');
is( $b->port,80,'test default port');
is( $b->timeout,60,'test default timeout seconds');

$b->host('192.168.1.1');
$b->port(3000);
$b->timeout(30);

is( $b->host, '192.168.1.1','test set host');
is( $b->port,3000,'test set port');
is( $b->timeout,30,'test set timeout');








    



