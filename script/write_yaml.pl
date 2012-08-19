use strict;
use warnings;
use YAML qw(Dump);
use Data::Dumper;
use File::Spec::Functions;

my $global_conf = {
    template_path => '~/code/pReader/conf/scraper/',
    scraper => {
        'www.ikindou.com' => {
            'Magazine' => 'www.ikindou.com/magazine.yml',
        },
    },
    db => {
        host => 'localhost',
        port => 3306,
        user => 'james',
        passwd => '19841002',
    },
};
print Dumper $global_conf;


my $output_dir = "/Users/wen/code/pReader/conf/";
my $output_file = catfile($output_dir,'global.yml');
if( !-e $output_file){
    system("touch $output_file");
    print ("touch $output_file\n");
}

YAML::Dump($global_conf);
YAML::DumpFile($output_file,$global_conf);







