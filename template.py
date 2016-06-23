#!/usr/bin/python
import optparse

OPTIONAL_DEFAULT_VAL="optional value"

def main():
    version="0.0.1"

    p = optparse.OptionParser(description="Program Description")
    ###metavar is text that appears in usage info. default is the value if the option isn't set by the user, dest is the attribute
    ###of options that is used.
    p.add_option('-o','--option',metavar="OPTIONARG",default=OPTIONAL_DEFAULT_VAL,help="what this option does",dest="some attribute of options")
    p.add_option('-f','--flag',dest="flag_variable",default=False,action="store_true" ,help="what this flag does")
    p.add_option("--debug", action="store_true", dest="debug", help="Turn on debug output")
    p.add_option('--logfile',metavar="FILE",default=None,help="Send debug output to file instead of stderr",dest="logfile")
    p.add_option('-V','--version', default=False, action="store_true", help="print the version and exit",dest="version")
    (options, arguments) = p.parse_args()

    if options.version:
        print "%s %s" % ( os.path.basename(__file__), version )
        exit()

    if options.debug:
        logging.basicConfig(filename=options.logfile,format='%(asctime)s %(levelname)s %(message)s',
                            level=logging.DEBUG)
        logging.debug("Debug logging turned on")
        logging.debug( "%s %s" % (os.path.basename(__file__), version ))
    else:
        logging.basicConfig(filename=options.logfile,format='%(asctime)s %(levelname)s %(message)s',
                            level=logging.WARNING)

  # Making sure all mandatory options appeared.
  mandatories = ['mandoption']
  for m in mandatories:
    if not options.__dict__[m]:
      print "mandatory option " + m + " is missing\n"
      p.print_help()
      exit(1)

def do_cmd(cmd):
    args=shlex.split(cmd)
    logging.info("Running command: %s" % cmd)
    try:
        #first line will only work in python 2.7.  Maybe with RHEL7...
        #cmd_out=subprocess.check_output(cmd, shell=True)
        p=subprocess.Popen(args, shell=False, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
        cmd_out=p.communicate()[0]
    except:
        print "couldn't execute command: %s" % cmd
        sys.exit(1)
    return cmd_out


if __name__ == '__main__':
  main()
