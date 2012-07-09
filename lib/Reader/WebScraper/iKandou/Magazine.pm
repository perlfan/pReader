package Reader::WebScraper::iKandou::Magazine;

use Moose;
use namespace::clean -except => 'meta';
use utf8;

extends 'Reader::WebScraper::iKandou';

my $domain = 'http://ikandou.com';

# overload callbacks
=pod
has '+callbacks' => (
    default => sub {
        {
            process_post_times => sub{
                my $element = shift;
                if( $element->as_text() =~ m/(\d+)/ ){
                    return $1;
                }
                return 0
            },
        }
    }
);
=cut

sub _process_post_times{
    my $e = shift;

    if( $e->as_text() =~ /^\D+?(\d+)/ ){
        return $1;
    }
    return 0;
}

sub _process_title_info{
    my $e = shift;
    return {
        link => $e->attr('href'),
        name => $e->as_text(),
    };
}

sub _process_desc{
    my $e = shift;
    my $text = $e->as_text();
    $text =~ s{^\s+}{}g;
    $text =~ s{\s+$}{}g;

    return $text;
}

sub _process_download_url{
    my $e = shift;
    my $href = $e->attr("href");

    return $domain.$href;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

