use strict;
use warnings;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Data::Dumper;
use Smart::Comments ;
use YAML qw(Dump);

use Test::More tests => 1;    # last test to print

BEGIN {
    use_ok('Reader::WebScraper::iKandou::Magazine');
};

my $yaml = '/home/nightlord/james/pReader/conf/scraper/ikandou.com/yy.yml';
my $spider = new Reader::WebScraper::iKandou::Magazine(
    config => $yaml
);
warn Dump $spider->scraper;

### test init config with yaml
my $callbacks = $spider->callbacks;
is( defined $callbacks->{_process_download_times} , 1,'test process_download_times callback');
is( defined $callbacks->{_process_post_times},1,'test process_post_times callback');
is( ref $spider->scraper,'Web::Scraper','test scraper init object');

### test parse html result
my $expect_html_result = {
    book_info => {
            name => 'CnBeta',
            post_times => '4383',
            download_url => 'http://ikandou.com/download/book/15',
    }
};
warn Dump $expect_html_result;

my $book_id = 1399;
my $url = 'http://ikandou.com/popular?page=2';
use LWP::UserAgent;
my $ua = LWP::UserAgent->new();
$ua->timeout(120);
my $res =$ua->get($url);
use Encode qw( decode_utf8);
my $html = decode_utf8( $res->content() );
my $hashref = $spider->parse($html); 
my $test_hashref = $hashref->{book_info}{list}[1];
warn Dump $hashref;
is_deeply( $test_hashref,$expect_html_result->{book_info},'test parse html result ');



