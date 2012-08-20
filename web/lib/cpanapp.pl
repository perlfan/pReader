#!/usr/bin/env perl
 
use strict;
use warnings;
 
use Mojolicious::Commands;
 
# Start commands for application
Mojolicious::Commands->start_app('CpanApp');
