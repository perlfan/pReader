use strict;
use warnings;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Data::Dumper;
use Smart::Comments;
use YAML qw(Dump);

use Test::More tests => 1;    # last test to print

BEGIN {
    use_ok('Reader::WebScraper::iKandou::Magazine');
};
use LWP::Simple;
my $html = get('http://ikandou.com/popular');
#my $config = 'ikandou.yml';
my $hashref = {
    scraper => [
        {
            process => [
                '//*[@id="bookmark_list"]',
                'book_info',
                {
                    scraper => [
                        {
                            process => [
                                '.tableViewCellTitleLink', 
                                'link',
                                '@href',
                                'name',
                                'TEXT',
                            ],
                        },
                        {
                            process => [
                                '.summary', 
                                'desc',
                                'TEXT',
                            ],
                        },
                        {
                            process => [
                                '.actionLink',
                                'download_link',
                                '@href',
                            ],
                        },
                        {
                            process => [
                                # nth
                                'div.secondaryControls > span.host:nth-child(5)',
                                'post_times',
                                '__callback(_process_post_times)__',
                            ],
                        }
                    ]
                }
            ]
        },
        {
            process => [
                '//*[@id="footer"]',
                'download_info',
                {
                    scraper => [
                        {
                            process => [
                                'a', 
                                'link',
                                '@href',
                            ],
                        },
                    ]
                }
            ]
        }
    ]
};
my $yaml = Dump($hashref);
print $yaml,"\n";


my $s = new Reader::WebScraper::iKandou::Magazine(
    config => $hashref, # hashref or config_file # for example : xml yaml json
);

is( ref ($s->config),'HASH','test config data structure');

my $r = $s->parse($html);
print $r->{book_info}->{desc},"\n";
print Dump $r;
my $expect_r = {
    link => 'http://ikandou.com/book/22',
    name => '豆瓣经典短篇阅读',
    desc => '名家名篇。王小波，鲁迅，村上春树，屠格涅夫，钱钟书，林语堂。',
    post_times => '27111',
    download_times => 6441
};

is_deeply($r,$expect_r,'test parse html result in website ikandou magazine');















