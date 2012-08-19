package EBookHelper::MOBI;

use Moose;
use namespace::clean except => '-meta';
use File::Spec::Functions;
use EBook::MOBI;
use Try::Tiny;

extends 'EBookHelper';

has 'author' => ( is => 'rw', isa => 'Str', default => 'somebody',  lazy => 1 );
has 'title'  => ( is => 'rw', isa => 'Str', default => 'sometitle', lazy => 1 );
has 'language' => ( is => 'rw', isa => 'Str', default => 'en', lazy => 1 );
has 'encoding' => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
    lazy    => 1,
);
has 'ebook' => (
    is      => 'rw',
    isa     => 'EBook::MOBI',
    default => sub { EBook::MOBI->new },
    lazy    => 1,
);

sub BUILD {
    my $self = shift;
    $self->ebook->set_title( $self->title );
    $self->ebook->set_author( $self->author );
    if ( $self->encoding ) {
        $self->ebook->set_encoding( ":encoding(" . $self->encoding . ")" );
    }
}

sub convert_pod2mobi {
    my $self    = shift;
    my $pod_str = shift;
    my $file    = shift;
    my $success;
    try {
        $self->ebook->set_filename($file);
        # sec args 1 is page_mode,
        if ( !$self->is_cache($file) ) {
            print "file $file is not cached\n";
            $self->ebook->add_pod_content( $pod_str, 0, 1 );
            $self->ebook->make();
            $self->ebook->save();
        }
        $success = 1;
    }
    catch {
        $success = 0;
    };
    return $success;
}

sub convert_html2mobi {
    my ( $self, $html, $file ) = @_;
    my $success;
    try {
        Carp::croak("file $file is not exists") unless -e $file;
        $self->ebook->set_filename($file);
        if ( !$self->is_cache($file) ) {
            $self->ebook->add_mhtml_content($html);
            $self->ebook->make();
            $self->ebook->save();
        }
        $success = 1;
    }
    catch {
        $success = 0;
    };
    return $success;
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;
__END__
