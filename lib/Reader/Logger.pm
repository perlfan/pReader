package Reader::Logger;

use Moose;
use namespace::clean -except => 'meta';
use Log::Handler;
use Carp;
use YAML qw(Dump LoadFile);

with "Reader::Constant";

has "config" => (
    is      => "rw",
    isa     => "Any",
    default => sub {
        [
            screen => {
                log_to   => "STDOUT",
                maxlevel => "debug",
                minlevel => "debug",
            },
            screen => {
                log_to   => "STDOUT",
                maxlevel => "debug",
                minlevel => "debug",
            },
            screen => {
                log_to   => "STDOUT",
                maxlevel => "info",
                minlevel => "notice",
            },
            screen => {
                log_to   => "STDERR",
                maxlevel => "warning",
                minlevel => "emergency",
            }
        ];
    },
    lazy => 1,
);

has "logger" => (
    is      => "ro",
    isa     => "Log::Handler",
    default => sub {
        return Log::Handler->new();
    },
    lazy => 1,
);

has 'autosave' => (
    is      => 'rw',
    isa     => 'Int',
    default => 1,
    lazy    => 1
);

has 'verbose' => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
    lazy    => 1,
);

sub BUILD {
    my $self = shift;
    
    if ( ref($self->config) eq $self->ARRAY){
        $self->logger->add(@{$self->config});
    }
    elsif ( -e $self->config ) {
        $self->load( $self->config );
    }
    else {
        Carp::croak(
            "Load logger conf " . Dump( $self->config ) . " failed\n" );
    }
}

sub load {
    my $self = shift;
    my $conf = shift;

    ### logging hashref
    my $logging_conf = LoadFile($conf)
      or Carp::croak("load yaml $conf failed,check your yaml\n");
    $self->logger->config($logging_conf);
    return 1;
}

sub reload {
    my ( $self, $conf ) = @_;
    $self->logger->reload($conf);
}

sub log {
    return shift->logger->log(@_);
}

sub debug {
    return shift->logger->debug(@_);
}
sub get_logger{
    return shift->logger;
}

sub warn {
    return shift->logger->warn(@_);
}

sub info {
    return shift->logger->info(@_);
}

sub error {
    return shift->logger->error(@_);
}

sub notice {
    return shift->logger->notice(@_);
}

sub dump {
    return shift->logger->dump(@_);
}

no Moose;
__PACKAGE__->meta->make_immutable;
1;

__END__
