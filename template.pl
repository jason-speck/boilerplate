#!/usr/bin/perl -w

# $Id: $
# $DateTime: $
# $Author: $
use strict;
#to use my perllib directory 
use FindBin qw($Bin);
use lib "$Bin/../perllib";
use lib "$Bin/perllib";

use Getopt::Long qw(:config no_ignore_case bundling);
use Sys::Hostname;
use File::Basename;

my $debug=0;
my $dryrun=0;
my $VERSION="0.1.0";
my $PROGNAME = basename($0);

my $options_ok = GetOptions ( 
#            'integer|i=i'    =>\$integer,
#            'string|s=s'     =>\$string,
#            'flag|f'         =>\$flag,

	     #meta-options
	     'dry-run'        =>\$dryrun,
	     'debug'          =>\$debug,
	     'version'          => sub { print_version() },
             'help'           => sub { print_usage() },
	   );

print_usage(1) if !$options_ok;
check_required_options();

my @required_files=();
my @required_executables=();
check_required_files(@required_files);
check_required_executables(@required_executables);


#THE MAIN ACTION


exit 0;

#FUNCTIONS
sub check_required_options {
#  if ( ! $option ) {
#    print_usage(1,"missing --option option");
#  }
}


sub check_required_files {
  my @files=@_;
  foreach ( @files ) {
    -e $_ or die "Required file $_ does not exist!";
  }
}

sub check_required_executables {
  my @files=@_;
  foreach ( @files ) {
    -x $_ or die "Required executable $_ does not exist or is not executable!";
  }
}

sub dprint {
  my ( $message ) = @_;
  print ("$message\n") if $debug;
}
sub print_version {
  print "$PROGNAME:  version $VERSION\n";
  exit;
}
  
sub print_usage {
  my  ( $exitstatus,$message) = @_;


  if ( defined ( $message ) && ! $message =~ m/^$/ )
  {
    print $message . "\n\n";
  }
  print "Usage:  " . $PROGNAME  .  " [options] \n";
  print <<EOM
Options:
  -o, --option=name          what option does

  --debug                    debug output
  --version                  print version information
  --help                     show this message
EOM
;
 $exitstatus = 0 unless defined $exitstatus;
 exit $exitstatus;

}
