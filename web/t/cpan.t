use FindBin qw($Bin);
use lib "$Bin/../lib";
use Test::More tests => 16;
use Test::Mojo;
use LWP::UserAgent;

BEGIN {
    use_ok('CpanApp');
    use_ok('EBookHelper::MOBI');
}

# Load application class
my $mobi_helper = new EBookHelper::MOBI(
    author   => 'james',
    title    => 'poe',
    language => 'en',
);
is($mobi_helper->author,'james','test mobi book author');
is($mobi_helper->title,'poe','test mobi book title');
is($mobi_helper->language,'en','test mobi book language');
use 5.010;
is($mobi_helper->encoding=~ m/UTF-8/i,'','test mobi book encode format');
my $t = Test::Mojo->new('CpanApp');
my $ua = new LWP::UserAgent;
$ua->timeout(60);
my $res = $ua->get("http://cpansearch.perl.org/src/RCAPUTO/POE-1.354/lib/POE.pm");
my $pod_str =$res->content;
my $mobi_file = '/Users/wen/Documents/poe.mobi';
is($mobi_helper->convert_pod2mobi($pod_str,$mobi_file),1,'test ebook pod->mobi');

is( $t->app->convert_pod2mobi($pod_str) =~ m/mobi$/,
    1, 'test convert_pod2mobi ok' );
is( $t->app->convert_pod2epub($pod_str) =~ m/epub$/,
   1, 'test convert_pod2epub ok' );
is( $t->app->convert_pods2mobi($pod_str) =~ m/epub$/,
    1, 'test convert_pod2epub ok' );
is( $t->app->convert_pods2epub($pod_str) =~ m/epub$/,
    1, 'test convert_pod2epub ok' );
$t->ua->max_redirects(1);
$t->get_ok('/ebook')->status_is(200);
$t->get_ok('/convert')->status_is(200);
done_testing;
