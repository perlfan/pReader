use strict;
use warnings;

use Test::More ;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Data::Dumper;
use Smart::Comments;

BEGIN{
    use_ok("Reader::Crawler");
};

# test creat crawler object
my $crawler = new Reader::Crawler( config => "/Users/wen/code/pReader/conf/global.yml");
is( $crawler->user_agent->isa("Reader::Protocol::HTTP"),1,'test useragent object');
is($crawler->log->isa("Reader::Logger"),1,'test Reader::Logger object');
is($crawler->exception->isa("Reader::Exception"),1,'test Reader::Exception object');
print Dumper $crawler->config;
is($crawler->config->isa("YAML"),1,'test YAML config file');
isnt($crawler->can('crawl'),undef,'test crawler has crawl method');
isnt($crawler->car('reload'),undef,'test crawler has reload file');

my $test_url = 'http://ikandou.com';
my $res = $crawler->crawl($test_url,'Magazine');

done_testing;



