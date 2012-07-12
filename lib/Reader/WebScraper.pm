package Reader::WebScraper;

use Moose;
use namespace::clean -except => 'meta';
use Web::Scraper::Config;
use Carp;
use URI;
use Data::Dumper;

with 'Reader::WebScraper::Helper';

our $VERSION = 1.0;

has 'config' => ( is => 'rw', );

has 'scraper' => (
    is      => 'rw',
    default => sub { {} },
    lazy    => 1,
);

has 'callbacks' => (
    is      => 'rw',
    isa     => "HashRef",
    default => sub { {} },
    lazy    => 1,
);

sub BUILD {
    my $self = shift;

    # add all class's scraper callbacks with mop
    {
        no strict 'refs';
        my $package = ref($self);

        # this role saves all common callbacks,like as : _process_del_attr
        my $role = "Reader::WebScraper::Helper";
        for my $method ( $role->meta->get_method_list,
            $package->meta->get_all_methods )
        {
            if ( ref($method) ) {
                $self->_add_callback( $method->name => $method->body )
                  if $method->name =~ m{^_process};
            }
            else {
                $self->_add_callback( $method => \&{ $role . "::" . $method } )
                  if $method =~ m{^_process};

            }
        }
    }

    # init web scraper
    my $scraper =
      new Web::Scraper::Config( $self->config,
        { callbacks => $self->callbacks, } );

    # set scraper
    $self->scraper($scraper);
}

sub _add_callback {
    my ( $self, $method_name, $coderef ) = @_;

    if ( ref($coderef) ne 'CODE' ) {
        Carp::croak("added method must be coderef");
    }
    $self->callbacks->{$method_name} = $coderef;
}

sub parse {
    my $self    = shift;
    my $content = shift;

    if ( $content =~ m/^http/ ) {
        return $self->scraper->scrape( URI->new($content) );
    }
    else {
        return $self->scraper->scrape($content);
    }
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME WebScraper







