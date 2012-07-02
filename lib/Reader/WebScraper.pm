package Reader::WebScraper;

use Moose;
use namespace::clean -except => 'meta';
use Web::Scraper::Config;
use Carp;
use URI;
use Data::Dumper;

our $VERSION = 1.0;

has 'config' => (
    is => 'rw',
);

has 'scraper' => (
    is => 'rw',
    default => sub { {} },
    lazy => 1,
);

has 'callbacks' => (
    is => 'rw',
    default => \&_def_callback,
    lazy => 1,
);

sub _def_callback{
    my $callbacks = {};
    $callbacks->{default_callback} = \&_default_callback;
    return $callbacks;
}

sub BUILD {
    my $self = shift;

    # add all class's scraper callbacks with mop
    {
        my $package = ref($self);
        my @callbacks = grep { $_->name =~ m/^_process/ } $package->meta->get_all_methods;
        for my $method( @callbacks ){
            $self->_add_callback(
                $method->name => $method->body
            );
        }
    }

    # init web scraper
    my $scraper = new Web::Scraper::Config(
        $self->config,{
            callbacks => $self->callbacks,
        }
    );
    # set scraper
    $self->scraper($scraper);
}

sub _add_callback{
    my ($self,$method_name,$coderef) = @_;
    
    if( ref($coderef) ne 'CODE' ){
        Carp::croak("added method must be coderef");
    }
    $self->callbacks->{$method_name} = $coderef;
}

sub parse{
    my $self = shift;
    my $content = shift;

    if( $content =~ m/^http/ ){
        return $self->scraper->scrape( URI->new($content) );
    }else{
        return $self->scraper->scrape($content);
    }
}

sub _default_callback{
    my $e = shift;
    return {
        href => $e->attr('href'),
        text => $e->as_text()
    };
}


no Moose;
__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME WebScraper







