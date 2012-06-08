#
#===============================================================================
#
#         FILE: exception.t
#
#  DESCRIPTION: 
#
#        FILES: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
#      COMPANY: 
#      VERSION: 1.0
#      CREATED: 06/08/2012 11:22:04 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;

use Test::More ;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Data::Dumper;
use Smart::Comments;

BEGIN{
    use_ok('Reader::Exception');
}

my $o = new Reader::Exception( error => 'testing');
Reader::Exception->throw( error => "this is a error testing" );

is( Reader::Exception->throw( "this is a error testing" ),1,'test throw method');
done_testing(7);



