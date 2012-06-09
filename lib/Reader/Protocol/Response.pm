package Reader::Protocol::Response;

use Moose;
use Reader::Exception;
use namespace::autoclean;
use AnyEvent::HTTP;
use TryCatch;
use Smart::Comments '###', '####';
use Moose::Util::TypeConstraints;

has 'header' => (
    is => 'ro',
    isa => 'HashRef',
    lazy => 1,
);

has 'content' => (
    is => 'ro',
    isa => "Str",
    lazy => 1,
);

__PACKAGE__->meta->make_immutable;

1;









