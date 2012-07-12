package Reader::WebScraper::Helper;

use Moose::Role;
use namespace::clean -except => 'meta';
use HTML::Entities ;

my @inline_elements = qw(
  a cite button em font i img dl input label small div
  span ins iframe style script center meta time
);


sub _process_del_attr {
    my $self = shift;
    my $element = shift;
    if( ref($self) eq 'HTML::Entities' ){
        $element = $self;
    }

    my $html    = $element->as_HTML;
    my $regex   = join "|", "<script[^>]+>.*?<\/script>",
      "<style[^>]+>.*?<\/style>",
      "<!--.*?-->",
      "<object[^>]>.*?</object>",
      map { "<\/?" . $_ . "[^>]*>" } @inline_elements;
    $html =~ s{$regex}{}igs;

    $html =~ s/\\n//g;
    $html =~ s/\\r//g;
    $html =~ s/\\r\\n//g;
    $html =~ s/(<\s*\w+)\s+[^>]*(>)/$1$2/g;
    $html =~ s/[\000-\037]//g;
    return HTML::Entities::decode($html);
}

1;

