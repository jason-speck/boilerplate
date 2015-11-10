#!/usr/bin/php5
<?php
$PROGNAME=basename($_SERVER["SCRIPT_NAME"]);
$VERSION="0.1.0";

$shortopts  = "";
#$shortopts .= "f:";  // Required value
#$shortopts .= "v::"; // Optional value
#$shortopts .= "abc"; // These options do not accept values

$longopts  = array(
    #"required:",     // Required value
    #"optional::",    // Optional value
    #"option",        // No value
    #"opt",           // No value
    "debug",           // No value
    "version",           // No value
    "help",           // No value
);
$options = getopt($shortopts, $longopts);

if ( array_key_exists ( "debug", $options )) {
  $DEBUG=1;
}
if ( array_key_exists ( "version", $options )) {
  print_version();
}

if ( array_key_exists ( "help", $options )) {
  print_usage();
}

function print_version () {
  global $PROGNAME;
  global $VERSION;
  print "$PROGNAME:  version $VERSION\n";
  exit;
}

function print_usage ($message="",$retval=0) {
  if ( $message ) {
    print "$message\n";
  }
  global $PROGNAME;
  print "Usage:  " . $PROGNAME  .  " [options] \n";
  print <<<EOM
Options:
  --debug                       debug output
  --version                     print version information
  --help                        show this message

EOM
;
 exit ($retval);
}


function dprint ($string) {
  #print if we have --debug flag set
  global $DEBUG;
  if ( $DEBUG ) {
    print $string;
  }
}



?>
