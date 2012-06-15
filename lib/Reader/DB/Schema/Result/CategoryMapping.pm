use utf8;
package Reader::DB::Schema::Result::CategoryMapping;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reader::DB::Schema::Result::CategoryMapping

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<category_mapping>

=cut

__PACKAGE__->table("category_mapping");

=head1 ACCESSORS

=head2 category_id

  data_type: 'integer'
  is_nullable: 0

=head2 sub_category_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "category_id",
  { data_type => "integer", is_nullable => 0 },
  "sub_category_id",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</category_id>

=item * L</sub_category_id>

=back

=cut

__PACKAGE__->set_primary_key("category_id", "sub_category_id");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-06-15 17:27:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:XhekZKCtLo4Fs+QMMdnldw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
