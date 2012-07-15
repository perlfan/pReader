package Reader::Protocol::HTTP;

use Moose;
use Reader::Exception;
use Regexp::Common qw /URI/;
use namespace::autoclean;
use AnyEvent::HTTP;
use TryCatch;
use Smart::Comments '###', '####';
use Moose::Util::TypeConstraints;
use FileHandle;
use Reader::Protocol::HTTP::Response;
use URI;

extends 'Reader::Protocol';

our $VERSION = 1.0;

subtype 'CookieJarHashRef',
  as 'HashRef',
  where { !ref($_) },
  message { "cookie_jar args must be hashref" };

has 'host' => (
    is      => 'rw',
    builder => '_default_host'
);
has 'port' => (
    is      => 'rw',
    builder => '_default_port'
);
has 'timeout' => (
    is      => 'rw',
    builder => '_default_timeout'
);
has 'agent' => (
    is      => 'rw',
    builder => '_default_agent',
    lazy    => 1
);
has 'recurse' => (
    is      => 'rw',
    builder => '_default_recurse',
    lazy    => 1
);
has 'keepalive' => (
    is      => 'rw',
    default => 1,
    lazy    => 1
);
has 'HEAD' => (
    is      => 'rw',
    builder => '_default_HEAD',
    lazy    => 1
);
has 'cookie_jar' => (
    is      => 'rw',
    default => sub { {} },
    lazy    => 1
);
has 'headers' => (
    is      => 'rw',
    default => sub { {} },
    lazy    => 1
);
has 'method' => (
    is      => 'rw',
    default => 'GET',
    lazy    => 1
);
has 'uri' => (
    is  => 'rw',
    isa => 'URI',
);
has 'proxy' => (
    is      => 'rw',
    default => undef,
    lazy    => 1,
);
has 'on_header' => (
    is      => 'rw',
    isa     => "Any",
    default => sub { {} },
    lazy    => 1,
);
has 'on_body' => (
    is      => 'rw',
    isa     => 'Any',
    default => sub { {} },
    lazy    => 1,
);

sub BUILD {
    my $self = shift;
    if ( $self->headers ) {
        $self->headers( { 'User-Agent' => $self->agent, } );
        AnyEvent::HTTP::set_proxy $self->proxy;
    }
}

sub clear_proxy {
    shift->proxy(undef);
    AnyEvent::HTTP::set_proxy undef;
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

    # init http_request args

    $self->HEAD( $self->uri( URI->new( $args{url} ) )->host( $args{url} ) );

    if ( ref( $self->on_header ) eq 'CODE' || ref( $self->on_body ) eq 'CODE' )
    {
        http_request(
            ( $args{method} || $self->method ) => delete $args{url},
            HEAD       => $self->HEAD,
            keepalive  => $self->keepalive,
            timeout    => $self->timeout,
            headers    => $self->headers,
            recurse    => $self->recurse,
            cookie_jar => $self->cookie_jar,
            on_header  => $self->on_header,
            on_body    => $self->on_body,
            $args{cb},
        );
    }
    else {
        http_request(
            ( $args{method} || $self->method ) => delete $args{url},
            HEAD       => $self->HEAD,
            keepalive  => $self->keepalive,
            timeout    => $self->timeout,
            headers    => $self->headers,
            recurse    => $self->recurse,
            cookie_jar => $self->cookie_jar,
            $args{cb},
        );
    }

=pod
    if ( ref( $self->on_header ) eq 'CODE' ) {
        $args{on_header} = $self->on_header;
    }
    if ( ref( $self->on_body ) eq 'CODE' ) {
        $args{on_body} = $self->on_body;
    }
=cut

    #    http_request( %option, $args{cb} );
    return 1;
}

sub download {
    my ( $self, $download_url, $file, $cb ) = @_;
    open my $fh, '+<', $file,
      or die "$file : $!";

    my %head_response;
    my $offset = 0;

    warn stat $fh;
    warn -s _;

    if ( stat $fh and -s _ ) {
        $offset = -s _;
        warn "-s is ", $offset;
        $head_response{"if-unmodified-since"} =
          AnyEvent::HTTP::format_date + ( stat _ )[9];
        $head_response{"range"} = "bytes=$offset-";
    }

    # set on header callback and on body callback
    $self->on_header(
        sub {
            my ($hdr) = @_;
            if ( $hdr->{Status} == 200 && $offset ) {

                # resume failed
                truncate $fh, $offset = 0;
            }
            sysseek $fh, $offset, 0;
            1;
        },
    );
    $self->on_body(
        sub {
            my ( $data, $hdr ) = @_;
            if ( $hdr->{Status} =~ /^2/ ) {
                length $data == syswrite $fh, $data
                  or return;    # abort on write errors
                1;
            }
        },
    );
    my $download_callback = sub {
        my ( undef, $hdr ) = @_;
        my $status = $hdr->{Status};

        if ( my $time = AnyEvent::HTTP::parse_date $hdr->{"last-modified"} ) {
            utime $fh, $time, $time;
        }
        if ( $status == 200 || $status == 206 || $status == 416 ) {

            # download ok || resume ok || file already fully downloaded
            $cb->( 1, $hdr );
        }
        elsif ( $status == 412 ) {

            # file has changed while resuming, delete and retry
            unlink $file, $cb->( 0, $hdr );
        }
        elsif ( $status == 500 or $status == 503 or $status =~ /^59/ ) {

            # retry later
            $cb->( 0, $hdr );
        }
        else {
            $cb->( undef, $hdr );
        }
    };
    $self->async_get( $download_url, $download_callback );
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


