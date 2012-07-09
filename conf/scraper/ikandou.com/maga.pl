#!/usr/bin/perl 
#===============================================================================
#
#         FILE: maga.pl
#
#        USAGE: ./maga.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
#      COMPANY: 
#      VERSION: 1.0
#      CREATED: 07/11/2012 03:50:28 PM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use YAML qw(Dump);

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
                                'div[id="tableViewCell176832828"]',
                                'list[]',
                                {
                                    scraper => [
                                        {
                                            process => [
                                                'span.subscribers',
                                                'subscribers',
                                                'TEXT',
                                            ],
                                        },
                                        {
                                            process => [
                                                'div.summary',
                                                'desc',
                                                'TEXT',
                                            ],
                                        },
                                        {
                                            process => [
                                                'a.tableViewCellTitleLink',
                                                'name',
                                                '__callbak(_process_desc)__',
                                            ],
                                        },
                                        {
                                            process => [
                                                'div.secondaryControls > span.host:nth-child(5)',
                                                'post_times',
                                                '__callbak(_process_post_times)__',
                                            ],
                                        },
                                        {
                                            process => [
                                                'a.actionLink',
                                                'download_url',
                                                '__callbak(_process_download_url)__',
                                            ],
                                        },
                                    ],
                                }
                            ],
                        }
                    ]
                }
            ]
        }
        
    ],
};

my $file = shift;

my $yml = YAML::DumpFile($file,$hashref);







