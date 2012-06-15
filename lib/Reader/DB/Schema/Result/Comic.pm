use utf8;
package Reader::DB::Schema::Result::Comic;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reader::DB::Schema::Result::Comic

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<comic>

=cut

__PACKAGE__->table("comic");

=head1 ACCESSORS

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 author

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 chapter

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 language

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 category_id

  data_type: 'integer'
  is_nullable: 1

=head2 sub_category_id

  data_type: 'integer'
  is_nullable: 1

=head2 insert_date_time

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 update_date_time

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 rating_stars

  data_type: 'float'
  is_nullable: 1

=head2 id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "author",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "chapter",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "language",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "category_id",
  { data_type => "integer", is_nullable => 1 },
  "sub_category_id",
  { data_type => "integer", is_nullable => 1 },
  "insert_date_time",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "update_date_time",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "rating_stars",
  { data_type => "float", is_nullable => 1 },
  "id",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-06-15 17:27:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:BIeMiYpSLBeZ3u+vrr1qig


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
