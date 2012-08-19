package Reader::Crawler;

use Moose;
use namespace::clean -except => 'meta';
use Reader::Exception;
use Carp;
use Reader::Logger;
use Reader::Protocol::HTTP;
use Reader::WebScraper;
use Data::Dumper;
use YAML;
use URI;
use File::Spec::Functions;
use 5.010;

has "user_agent" => (
    is      => 'rw',
    isa     => 'Reader::Protocol::HTTP',
    default => sub {
        Reader::Protocol::HTTP->new;
    },
    lazy => 1
);

has "log" => (
    is      => 'rw',
    isa     => 'Reader::Logger',
    default => sub {
        Reader::Logger->new;
    },
    lazy => 1,
);

has "exception" => (
    is      => 'rw',
    isa     => 'Reader::Exception',
    default => sub {
        Reader::Exception->new;
    },
    lazy => 1,
);
has "scraper" => (
    is      => 'rw',
    isa =>'Any',
    default => sub { {} },
);
has "config_file" => (
    is      => 'rw',
    isa     => "Any",
    required=> 1
);
has 'config' => (
    is => 'rw',
    isa => 'Any',
    default => sub { {} },
    lazy =>1,
);

sub BUILD{
    my $self = shift;
    if(-e $self->config_file ){
        $self->config =YAML::LoadFile( $self->config_file );
     }else{
         Carp::croak


sub crawl {
    my $self     = shift;
    my $url      = shift;
    my $web_type = shift;

    my $res;
    my $uri = new URI($url);

    # webscraper
    my $w              = "Reader::Webscraper::" . $uri->host;
    my $parse_template = catfile( $self->{config}->{template_path},
        $self->config->{scraper}{ $uri->host }{$web_type} );
    if ( !-e $parse_template ) {
        $self->log->error("parse template is not exists $parse_template");
    }
    $self->config($parse_template);
    require $w or $self->exception->throw("load class $w failed");
    return $w->new( config => $parse_template )->parse($url);
}

sub reload {
}

no Moose;
__PACKAGE__->meta->make_immutable;
