package Reader::Logger::Interface;

use Moose::Role;
use namespace::clean -except => 'meta';

requires qw(
    load reload log debug get_logger warn info error
    notice dump
);

1;
__END__

