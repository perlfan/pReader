package Reader::WebScraper::iKandou::Magazine;

use Moose;
use namespace::clean -except => 'meta';
use utf8;

extends 'Reader::WebScraper::iKandou';

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
    print $e->as_HTML;
    print $e->dump;
    print $e->as_text;
    if( $e->as_text() =~ /^\D+?(\d+)/ ){
        return $1;
    }
    undef;
}

sub _process_title_info{
    my $e = shift;
    print $e->as_HTML;
    return {
        link => $e->attr('href'),
        name => $e->as_text(),
    };
}


no Moose;
__PACKAGE__->meta->make_immutable;
1;

