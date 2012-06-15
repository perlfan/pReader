use utf8;
package Reader::DB::Schema::Result::Subscription;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reader::DB::Schema::Result::Subscription

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<subscription>

=cut

__PACKAGE__->table("subscription");

=head1 ACCESSORS

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 link

  data_type: 'varchar'
  is_nullable: 1
  size: 32

=head2 domain

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 domain_id

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "name",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "id",
  { data_type => "integer", is_nullable => 0 },
  "link",
  { data_type => "varchar", is_nullable => 1, size => 32 },
  "domain",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "domain_id",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-06-15 17:27:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:KW3teq3HsztupG+nQS10Gw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
