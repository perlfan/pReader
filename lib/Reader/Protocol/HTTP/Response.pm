package Reader::Protocol::HTTP::Response;

use Reader::Exception;
use Moose;
use namespace::autoclean;
use AnyEvent::HTTP;
use TryCatch;
use Smart::Comments '###', '####';
use Moose::Util::TypeConstraints;
use HTTP::Response;
use HTTP::Headers;

with 'Reader::Protocol::HTTP::Interface';

has 'h' => (
    is  => 'ro',
    isa => 'HashRef',
);

has 'c' => (
    is  => 'ro',
    isa => "Str",
);

has 'response' => (
    is      => 'ro',
    isa     => "HTTP::Response",
    handles => [
        qw(
          is_success header is_redirect code status_line decoded_content
          previous as_string is_error content
          error_as_HTML
          )
    ],
    default => sub { {} },
    lazy    => 1
);

around BUILDARGS => sub {
    my $orig  = shift;
    my $class = shift;
    my @args  = @_;

    if ( @args == 2 and !ref($class) ) {
        my ( $h, $c ) = @args;
        my $code    = delete $h->{Status};
        my $message = delete $h->{Reason};

        delete $h->{$_}
          foreach qw(HTTPVersion OrigStatus OrigReason Redirect URL);
        my $headers = HTTP::Headers->new;
        while ( my ( $k, $v ) = each %$h ) {
            my @list = $v =~ /^([^ ].*?[^ ],)*([^ ].*?[^ ])$/;
            @list = grep { defined($_) } @list;
            if ( scalar(@list) > 1 ) {
                @list = map { s/,$//; $_ } @list;
                $v = [@list];
            }
            $headers->header( $k => $v );
        }
        if ( $code >= 590 && $code <= 599 ) {
            if ( $message =~ /timed/ && $code == 599 ) {
                $c = "500 read timeout";
            }
            elsif ( !defined($c) || $c =~ /^\s*$/ ) {
                $c = $message;
            }
        }
        return $class->$orig(
            header   => $h,
            content  => $c,
            response => HTTP::Response->new( $code, $message, $headers, $c )
        );
    }
    else {
        $class->$orig(@args);
    }
};

__PACKAGE__->meta->make_immutable;

1;

