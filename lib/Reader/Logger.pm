package Reader::Logger;

use Moose;
use namespace::clean -except => 'meta';
use Log::Handler;
use Carp;
use YAML qw(Dump LoadFile);

with "Reader::Logger::Basic","Reader::Logger::Interface";

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__
