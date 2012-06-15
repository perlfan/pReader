use utf8;
package Reader::DB::Schema::Result::Task;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reader::DB::Schema::Result::Task

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<task>

=cut

__PACKAGE__->table("task");

=head1 ACCESSORS

=head2 task_id

  data_type: 'integer'
  is_nullable: 0

task_id number

=head2 status

  data_type: 'varchar'
  default_value: ''undo''
  is_nullable: 1
  size: 20

record task finish status

=head2 task_type

  data_type: 'varchar'
  is_nullable: 1
  size: 20

=head2 start_time

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 end_time

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 update_date_time

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 link

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "task_id",
  { data_type => "integer", is_nullable => 0 },
  "status",
  {
    data_type => "varchar",
    default_value => "'undo'",
    is_nullable => 1,
    size => 20,
  },
  "task_type",
  { data_type => "varchar", is_nullable => 1, size => 20 },
  "start_time",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "end_time",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "update_date_time",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "link",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</task_id>

=back

=cut

__PACKAGE__->set_primary_key("task_id");


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-06-15 17:27:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jhsVvXVPsyLSE7FWfBr70Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
