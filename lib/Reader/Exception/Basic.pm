package Reader::Exception::Basic;

use MooseX::Role::WithOverloading;
use Carp;
use namespace::clean -except => 'meta';

with 'Reader::Exception::Interface';

has message => (
    isa     => 'Str',
    is      => 'ro',
    lazy    => 1,
    default => sub { $! || '' }
);

sub as_string {
    my ($self) = @_;
    return $self->message;
}

around BUILDARGS => sub {
    my ( $origin, $class, @args ) = @_;
    if ( @args == 1 && !ref( $args[0] ) ) {
        @args = ( message => $args[0] );
    }
    my $args = $class->$origin(@args);
    $args->{message} ||= $args->{error} if exists $args->{error};

    return $args;
};

sub throw {
    my $class = shift;
    my $error = $class->new(@_);
    local $Carp::CarpLevel = 1;
    croak $error. "\n";
}

1;

__END__



