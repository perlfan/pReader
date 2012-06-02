package Reader::Protocol::HTTP;

use Moose;
use namespace::autoclean;
use Carp qw( croak );
use AnyEvent::HTTP;

our $VERSION = 1.0;

has 'host'      => ( is => 'rw', builder => '_default_host' );
has 'port'      => ( is => 'rw', builder => '_default_port' );
has 'timeout'   => ( is => 'rw', builder => '_default_timeout' );
has 'agent'     => ( is => 'rw', builder => '_default_agent', lazy => 1 );
has 'recurse'   => ( is => 'rw', builder => '_default_recurse', lazy => 1 );
has 'keepalive' => ( is => 'rw', default => 1, lazy => 1 );
has 'HEAD'      => ( is => 'rw', builder => '_default_HEAD', lazy => 1 );

sub _default_HEAD {
    no strict 'refs';
    return $AnyEvent::HTTP::HEAD;
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

sub get {
    my $self = shift;
    my $url  = shift;

    my $http_response = {};

    # default block model
    my $default_cb = sub {
        my ( $body, $hr ) = @_;
        my $http_response = {};
        $http_response->{content} = $body;
        $http_response->{header}  = $hr;
    };

    http_get(
        $url,
        headers   => $self->headers,
        HEAD      => $self->HEAD,
        recurse   => $self->max_recurse,
        timeout   => $self->timeout,
        keepalive => $self->keepalive,
        $default_cb
    );

    return $http_response;
}

sub get_and_process {
    my $self = shift;
    my $url  = shift;
    my $cb   = shift;
    my %args = @_;

    if ( ref($cb) ne 'CODE' ) {
        croak qq{ please pass coderef \n};
    }

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

__PACKAGE__->meta()->make_immutable();
1;

