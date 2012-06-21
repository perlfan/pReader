
use strict;
use warnings;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Data::Dumper;
use Smart::Comments;

use Test::More;

BEGIN{
    use_ok('Reader::Protocol::HTTP::Response');
}

use AnyEvent::HTTP;
use AnyEvent;

my $cv = AnyEvent->condvar;

my ($header,$content);
### get sina web for test
$cv->begin;
http_get 'http://www.sina.com.cn',sub { 
    my ($c,$h) = @_;
    print Dumper $h; 
    ( $header,$content)=($h,$c); 
    $cv->end; 
};
$cv->recv;
my $r = Reader::Protocol::HTTP::Response->new(
    $header,$content
);
is( $r->is_success,1,'test is_success func');
is( $r->code,200,'test code func');
is( $r->is_redirect,'','test redirect func');
is( $r->status_line,'200 OK','test status_line func');
is( index($r->content,'</html>')!=-1,1,'test content func');


done_testing;




