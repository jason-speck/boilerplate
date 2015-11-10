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
use DBI;
use POSIX;

my $db;
my $host="127.0.0.1";  #need to use loopback address so uses TCP instead of unix domain socket
my $port=3306;
my $dbpass;
my $dbuser=getlogin;

my $debug=0;
my $dryrun=0;
my $VERSION="0.1.0";
my $PROGNAME = basename($0);

my $options_ok = GetOptions ( 
#            'integer|i=i'    =>\$integer,
#            'string|s=s'     =>\$string,
#            'flag|f'         =>\$flag,
             'database|D=s'   =>\$db,
             'host|h=s'       =>\$host,
             'port|P=i'       =>\$port,
             'user|u=s'       =>\$dbuser,
             'password|p:s'   =>\$dbpass,

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

#prompt for the password if the user used --password but didn't but pw on command line:
if ( defined $dbpass && $dbpass eq "" )  {
  #write directly to the tty so that if stdout is redirected, 
  #the password prompt still appears
  my $tty = POSIX::ctermid();
  open(TTY, ">$tty") or die "couldn't open $tty for write";
  print TTY "Enter password: ";
  !system("stty -echo")  || die "couldn't turn echo off";
  $dbpass=<STDIN>;
  !system("stty echo")  || die "couldn't turn echo back on";
  chomp $dbpass;
  print TTY "\n";
  close TTY;
}

my $dbh;
$dbh=DBI->connect("DBI:mysql:host=$host;database=$db;port=$port",$dbuser,$dbpass,{ PrintError => 0, })
    or die "couldn't connect to mysql server: $DBI::errstr";

#THE MAIN ACTION

$dbh->disconnect();

exit 0;

#FUNCTIONS
sub check_required_options {
  if ( ! $db ) {
    print_usage(1,"missing --database option");
  }
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
  -h, --host=name            host to connect to
  -P, --port=#               port to connect to
  -u, --user=name            user for login if not current user
  -p, --password[=name]      password to use.  If password not given, will prompt
  -D, --database=name        database to use

  --debug                    debug output
  --version                  print version information
  --help                     show this message
EOM
;
 $exitstatus = 0 unless defined $exitstatus;
 exit $exitstatus;

}
