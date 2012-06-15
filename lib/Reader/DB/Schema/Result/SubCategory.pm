use utf8;
package Reader::DB::Schema::Result::SubCategory;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reader::DB::Schema::Result::SubCategory

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<sub_category>

=cut

__PACKAGE__->table("sub_category");

=head1 ACCESSORS

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 id

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "id",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->set_primary_key("name");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-06-15 17:27:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LEcOwWeDFtN5zhCAIHxo9Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
