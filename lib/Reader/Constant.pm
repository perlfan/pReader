package Reader::Constant;

use Moose::Role;
use namespace::clean -except => 'meta';
use YAML qw(Dump LoadFile);

has "HASH" => (
    is => "ro",
    isa => "Str",
    default => "HASH",
    lazy => 1,
);
has "ARRAY" => (
    is => "ro",
    isa => "Str",
    default => "ARRAY",
    lazy => 1,
);

has "CODE" => (
    is => "ro",
    isa => "Str",
    default => "CODE",
    lazy => 1,
);


1;

__END__
