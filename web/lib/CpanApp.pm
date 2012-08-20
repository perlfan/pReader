package CpanApp;
use FindBin qw($Bin);
use lib "$Bin";
use Mojo::Base 'Mojolicious';
use EBookHelper::MOBI;
use EBookHelper::EPUB;

sub startup {
  my $self = shift;
  my $ebook_adaptor = {
      mobi => new EBookHelper::MOBI,
      epub => new EBookHeper::EPUB,
  };
  $self->helper( ebook_helper => $ebook_adaptor);

  my $r = $self->routes;
  $r->get('/')->to('convertor#index')->name('index');
}
1;
