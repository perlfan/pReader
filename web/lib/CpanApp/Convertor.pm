package CpanApp::Convertor;

use Mojo::Base 'Mojolicious::Controller';

sub ebook{
    my $self = shift;
    $self->render(text => 'hello ebook!');
}

sub index{
    my $self = shift;
    $self->render(text => 'james,hello cpan ebook client');
}

sub convert{
}
1;
