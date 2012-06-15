use strict;
use warnings;
use Data::Dumper;
use DBIx::Class::Schema::Loader qw/ make_schema_at /;
use Carp qw( croak );
use FindBin qw($Bin);

my $import_dir = shift;

if ( !-d $import_dir ) {
    croak qq{wrong import dir $import_dir\n};
}

make_schema_at(
    'Reader::DB::Schema',
    {
        debug          => 1,
        dump_directory => $import_dir,
    },
    [
        'dbi:mysql:preader:192.168.3.125', 'root', 'root',
    ],
)
