package CpanApp;
use FindBin qw($Bin);
use lib "$Bin";
use lib 'lib';
use Mojo::Base 'Mojolicious';
use EBookHelper::MOBI;

sub startup {
  my $self = shift;
}
 
1;
