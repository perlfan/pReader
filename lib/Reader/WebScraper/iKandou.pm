package Reader::WebScraper::iKandou;

use Moose;
use namespace::clean -except => 'meta';


extends 'Reader::WebScraper';

no Moose;
__PACKAGE__->meta->make_immutable;
