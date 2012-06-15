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
    my $b = Reader::Protocol::HTTP->new();
    $b->agent("chrome");
    goto Async;
    my $response = $b->get("http://www.sina.com.cn");
    is( ref($response),'Reader::Protocol::HTTP::Response','test response object');
    is( $response->is_success,1,'test res is sucess');
    is( $response->code,200,'test return code is 200');
    is( index($response->content,'<html>')!=-1,1,'test html return');

    my $w = $b->get("www.sina.com");
    is( ref($response),'Reader::Protocol::HTTP::Response','test return response object');
    isnt( $w->is_success,1,'test res is sucess');
    isnt( $w->code,200,'test return code is 200');
    isnt( index($w->content,'<html>')!=-1,1,'test html return');

    Async:
    # Mozilla/5.0 (iPad; U; CPU OS 3_2_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B500 Safari/531.21.10
    my $cv = AnyEvent->condvar;
    foreach ('http://www.sina.com.cn','http://www.51nb.com','http://www.baidu.com',
        'http://www.google.com/',
        'http://video.sina.com.cn/movie/ipad/'){
        if( /www.sina/ ){
            $cv->begin;
            $b->async_get($_,sub {
                    my ($body,$hr) = @_;
                    my $r = Reader::Protocol::HTTP::Response->new($hr,$body);
                    is($r->code,200,'test sina http get 200 OK');
                    $cv->end;
                }
            );
        }
        if( /google.com/ ){
            $cv->begin;
            $b->async_simple_request($_,
                sub {
                    my ($b,$h)=@_;
                    my $r = Reader::Protocol::HTTP::Response->new($h,$b);
                    is($r->code,302,'test google link redirect 302');
                    $cv->end;
                },
                'GET',
            );
        }
        if( /ipad/ ){
            $cv->begin;
            $b->agent(
    'Mozilla/5.0 (iPad; U; CPU OS 3_2_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B500 Safari/531.21.10'
            );
            $b->async_get($_,
                sub {
                    my ($b,$h)=@_;
                    my $r = Reader::Protocol::HTTP::Response->new($h,$b);
                    is($r->code,200,'test ipad link get ok with iapd agent');
                    $cv->end;
                },
            );
        }
    }
    #$cv->end;
    print "hello endend...........................\n";
    $cv->recv;

}

test_init_func();
test_download();

TODO: {
        local $TODO = 'cookie_jar and proxy function need later';
        warn $TODO;
        my $ua = Reader::Protocol::HTTP->new();
        is( $ua->cookie_jar(),1,'test cookie jar');
        is( $ua->proxy(),1,'test proxy function');
};

