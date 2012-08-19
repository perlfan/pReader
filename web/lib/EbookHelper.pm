package EBookHelper;

use Moose;
use namespace::clean except => 'meta';
use File::Basename;
use Carp;

sub is_cache {
    my ( $self, $file ) = @_;
    my $is_cache;
    if ( -e $file and -s $file > 0 and $self->verify_ebook($file) ) {
        $is_cache = 1;
    }
    else {
        system("rm $file");
        system("touch $file");
        $is_cache = 0;
    }
    return $is_cache;
}

sub verify_ebook {
    my $self = shift;
    my $file = shift;
    my $is_ebook;

    my ($ebook_extension) = $file =~ m{\.([^\.]+)$};
    my $pid = open( FD, "file $file 2>/dev/null |" )
      or Carp::croak("this is a invalid file");
    while (<FD>) {
        chomp;
        if (/$ebook_extension/i and /E-book/i) {
            $is_ebook = 1;
        }
    }

    close(FD);
    return $is_ebook;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
__END__


