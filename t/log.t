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
use Smart::Comments;

use Test::More;

BEGIN {
    use_ok('Reader::Logger');
}

my $config = '';
### test create logger object
my $logger = Reader::Logger->new();
my $log = $logger->get_logger();

### test logger method invoke
is( ref($log),              'Log::Handler', 'test init object type' );
# TODO reload
#is( $log->reload($config),  1,                'test reload logger conf' );

is( $log->dump(),           1,                'test dump config' );
is( $log->debug('debug'),   1,                'test debug message method' );
is( $log->info('info'),     1,                'test info message method' );
is( $log->warn('warn'),     1,                'test warn message method' );
is( $log->notice('notice'), 1,                'test notice message method' );
is( $log->error('error'),   1,                'test error message method' );
is( $log->log( warn   => 'log warn msg' ), 1,  'test log method => warn msg' );
is( $log->log( debug  => 'log debug msg' ), 1, 'test log method => debug msg' );
is( $log->log( info   => 'log info msg' ),  1, 'test log method => info msg' );
is( $log->log( notice => 'log notice msg' ), 1,'test log method => notice msg' );
is( $log->log( error  => 'log notice msg' ), 1,'test log method => notice msg' );

done_testing();

