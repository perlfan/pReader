use utf8;
package Reader::DB::Schema::Result::Book;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reader::DB::Schema::Result::Book

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<book>

=cut

__PACKAGE__->table("book");

=head1 ACCESSORS

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 author

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 chapter

  data_type: 'integer'
  is_nullable: 1

=head2 format

  data_type: 'varchar'
  is_nullable: 1
  size: 32

format of books ,example : mobi,epub

=head2 rating_stars

  data_type: 'float'
  is_nullable: 1

=head2 desc

  data_type: 'mediumtext'
  is_nullable: 1

=head2 rating_times

  data_type: 'float'
  is_nullable: 1

=head2 category_id

  data_type: 'integer'
  is_nullable: 1

=head2 sub_category_id

  data_type: 'integer'
  is_nullable: 1

=head2 download_times

  data_type: 'integer'
  is_nullable: 1

=head2 related_book

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 publish_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 publish_company

  data_type: 'varchar'
  is_nullable: 1
  size: 255

publish company of book

=head2 cover

  data_type: 'varchar'
  is_nullable: 1
  size: 255

front cover of book

=head2 language

  data_type: 'varchar'
  default_value: 'zh_cn'
  is_nullable: 1
  size: 32

language of book,example : zh_cn

=cut

__PACKAGE__->add_columns(
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "id",
  { data_type => "integer", is_nullable => 0 },
  "author",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "chapter",
  { data_type => "integer", is_nullable => 1 },
  "format",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "rating_stars",
  { data_type => "float", is_nullable => 1 },
  "desc",
  { data_type => "mediumtext", is_nullable => 1 },
  "rating_times",
  { data_type => "float", is_nullable => 1 },
  "category_id",
  { data_type => "integer", is_nullable => 1 },
  "sub_category_id",
  { data_type => "integer", is_nullable => 1 },
  "download_times",
  { data_type => "integer", is_nullable => 1 },
  "related_book",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "publish_date",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "publish_company",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "cover",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "language",
  {
    data_type => "varchar",
    default_value => "zh_cn",
    is_nullable => 1,
    size => 32,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-06-15 17:27:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MLpRU6tdC9GRP9fdVWsU8Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
