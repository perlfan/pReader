package EBookHelper::EPUB;

use Moose;
use namespace::clean qw(-meta);
use File::Spec::Functions;
use Carp;

extends 'EBookHelper';

no Moose;
__PACKAGE__->meta->make_immutable;

1;
__END__
