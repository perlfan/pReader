package Reader::Protocol::HTTP;

use Moose;
use namespace::autoclean;
use Carp qw( croak );
use AnyEvent::HTTP;

has 'host' => (
    is      => 'rw',
    builder => '_default_host',
);

has 'port' => (
    is      => 'rw',
    builder => '_default_port',
);

has 'timeout' => (
    is      => 'rw',
    lazy    => 1,
    builder => '_default_timeout',
);

has 'agent' => (
    is      => 'rw',
    lazy    => 1,
    builder => '_default_agent',
);

has 'header' => (
    is      => 'rw',
    lazy    => 1,
    builder => '_default_header',
);

sub CODE() { 'CODE' }

sub _default_port {
    my $self = shift;
    return 80;
}

sub _default_host {
    my $self = shift;
    return '127.0.0.0';
}

sub _default_timeout {
    my $self = shift;
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

