package Reader::Protocol::HTTP;

use Moose;
use Reader::Exception;
use Regexp::Common qw /URI/;
use namespace::autoclean;
use AnyEvent::HTTP;
use TryCatch;
use Smart::Comments '###', '####';
use Moose::Util::TypeConstraints;
use Reader::Protocol::HTTP::Response;
use URI;

extends 'Reader::Protocol';

our $VERSION = 1.0;

subtype 'CookieJarHashRef',
  as 'HashRef',
  where { !ref($_) },
  message { "cookie_jar args must be hashref" };

has 'host'       => ( is => 'rw', builder => '_default_host' );
has 'port'       => ( is => 'rw', builder => '_default_port' );
has 'timeout'    => ( is => 'rw', builder => '_default_timeout' );
has 'agent'      => ( is => 'rw', builder => '_default_agent', lazy => 1 );
has 'recurse'    => ( is => 'rw', builder => '_default_recurse', lazy => 1 );
has 'keepalive'  => ( is => 'rw', default => 1, lazy => 1 );
has 'HEAD'       => ( is => 'rw', builder => '_default_HEAD', lazy => 1 );
has 'cookie_jar' => ( is => 'rw', default => sub { {} }, lazy => 1 );
has 'headers'    => ( is => 'rw', default => sub { {} }, lazy => 1 );
has 'method' => ( is => 'rw', default => 'GET', lazy => 1 );
has 'uri' => ( is => 'rw', isa => 'URI', );

sub BUILD {
    my $self = shift;
    if ( $self->headers ) {
        $self->headers( { 'User-Agent' => $self->agent, } );
    }
}

sub _default_HEAD {
    '127.0.0.0';
}
sub CODE() { 'CODE' }

sub _default_recurse {
    return 7;
}

sub _default_agent {
    return 'firefox';
}

sub _default_port {
    return 80;
}

sub _default_host {
    return '127.0.0.0';
}

sub _default_timeout {
    return 60;
}

sub _on_header {
    my @args = @_;
}

sub get {
    my $self = shift;
    my $url  = shift;

    my $cv = AnyEvent->condvar;
    $cv->begin;
    my $default_cb = sub {
        my ( $body, $hr ) = @_;
        ### this will return the http response object
        my $res = Reader::Protocol::HTTP::Response->new( $hr, $body );
        $cv->send($res);
    };

    http_get( $url, $default_cb );
    my $r = $cv->recv;
    return $r;
}

sub get_and_process {
    my $self = shift;
    my $url  = shift;
    my $cb   = shift;
    my %args = @_;

    if ( ref($cb) ne 'CODE' ) {
        Reader::Exception->throw( error => 'uninit callback func' );
    }

    ### nonblock get url with url => $url
    http_get(
        $url,
        headers   => $self->headers,
        HEAD      => $self->HEAD,
        recurse   => $self->max_recurse,
        timeout   => $self->timeout,
        keepalive => $self->keepalive,
        $cb
    );

    undef;
}

# http async request func : async_get ,async_post,async_request method
# we use these methods to simulation http request and parse html
# args like example:
#     $o->async_post($url,sub { xxxx });
sub async_get {
    my $self = shift;
    my $url  = shift;
    my $cb   = shift;
    $self->_request(
        url => $url,
        cb  => $cb,
    );
}

sub async_post {
    my $self = shift;
    my $url  = shift;
    my $cb   = shift;
    my %args = @_;

    return $self->_request( url => $url, cb => $cb, method => 'POST' );
}

sub async_request {
    my ( $self, $url, $cb, $method ) = @_;
    return $self->_request( url => $url, cb => $cb, method => $method );
}

sub async_simple_request {
    my ( $self, $url, $cb, $method ) = @_;
    return $self->_simple_request( $url, $cb, $method );
}

sub _simple_request {
    my $self   = shift;
    my $url    = shift;
    my $cb     = shift;
    my $method = shift;
    $self->recurse(1);
    $self->_request( url => $url, cb => $cb, method => $method );
}

sub _request {
    my $self = shift;
    my %args = @_;

    if ( $args{url} !~ m/$RE{URI}{HTTP}/ ) {
        Reader::Exception->throw( error => 'invalid http uri ' . $args{url} );
    }
    #### Dumper \%args
    if ( ref( $args{cb} ) ne 'CODE' ) {
        Reader::Exception->throw( error => 'wrong callback code' );
    }

    $self->HEAD( $self->uri( URI->new( $args{url} ) )->host( $args{url} ) );
    http_request(
        ( $args{method} || $self->method ) => delete $args{url},
        HEAD      => $self->HEAD,
        keepalive => $self->keepalive,
        timeout   => $self->timeout,
        headers   => $self->headers,
        recurse   => $self->recurse,
        $args{cb},
    );
    return 1;
}

no Moose;
__PACKAGE__->meta()->make_immutable();

1;

=pod

=head1 NAME  pReader::Protocol::HTTP

A module which used to simulation lwp and http protocol,it written by AnyEvent::HTTP and encapsulated by Moose.

=head1 DESCRIPTION

    use pReader::Protocol::HTTP;

    my $h = pReader::Protocol::HTTP->new(
        agent => 'xxxx',
        port => 'xxx',
        host => 'xxxx',
    );


=head1 METHOD LIST 

some example and how to use this module to simulate http.

=head2 get($url,on_header => sub {},on_body => sub {})

A nonblock get method ,it encapsulate anyevent http protocol, so it runs faster than lwp.

=cut

__END__


