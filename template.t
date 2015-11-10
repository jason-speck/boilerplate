#!/usr/bin/perl
use strict;
use warnings;
use FindBin qw($Bin);
my $program="check_all";

use Test::Simple tests => 1;

chdir "$Bin/.." || die "couldn't change dirs!" ;  #more readable if run program to test from it's directory

ok( -x "$program", "$program exists" );              #make sure program we're testing is there

#my $cmdline;

#$cmdline="./$program --type=p4 -c Jason -e $date -s $date -i 127.1.1.1 -u 30  -Ajason\@foo.com  --dry-run ";
#ok ($license_date eq "2010/03/02",  "license expiry changed from $day to Tuesday");


