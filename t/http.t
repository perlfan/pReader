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

use Test::More tests => 1;    # last test to print

BEGIN {
    use_ok('Reader::Protocol::HTTP');
}

my $b = Reader::Protocol::HTTP->new();

sub test_init_func {
    # Host:, Content-Length:, Connection: and Cookie: User-Agent
    # HEAD: http://www.google.com.hk
    is( $b->host,    '127.0.0.0', 'test default host' );
    is( $b->port,    80,          'test default port' );
    is( $b->timeout, 60,          'test default timeout seconds' );
    is( $b->agent,'firefox','test default agent str');
    is( ref $b->cookie_jar,ref {},'test default cookie jar' );
    is( $b->recurse,7,'test max redirect' );

### test set host ,port,timeout
    $b->host('192.168.1.1');
    $b->port(3000);
    $b->timeout(30);
    $b->agent("test agent");
    $b->HEAD('127.0.0.1');
    $b->recurse(10);
    $b->headers({ 'Content-Length' => 400 } );

    is( $b->host,    '192.168.1.1', 'test set host' );
    is( $b->port,    3000,          'test set port' );
    is( $b->timeout, 30,            'test set timeout' );
    is( $b->agent, "test agent",'test agent');
    is( $b->HEAD,'127.0.0.1','test seted HOST' );
    is( $b->recurse,10,'test recurse set ');
}

sub test_download{
    $b->agent("chrome");
    my $response = $b->get("www.sina.com.cn");
    is( $response->is_success,1,'test get response success');
    is( $response->is_success,0,'test get response not success');
}

test_init_func();
test_download();

