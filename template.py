#!/usr/bin/python
import optparse

OPTIONAL_DEFAULT_VAL="optional value"

def main():
  p = optparse.OptionParser(description="program description")
  ###metavar is text that appears in usage info. default is the value if the option isn't set by the user, dest is the attribute
  ###of options that is used.
  p.add_option('-o','--option',metavar="OPTIONARG",default=OPTIONAL_DEFAULT_VAL,help="what this option does",dest="some attribute of options")
  p.add_option('-f','--flag',dest="flag_variable",default=False,action="store_true" ,help="what this flag does")
  (options, arguments) = p.parse_args()
  optionval=options.option

  # Making sure all mandatory options appeared.
  mandatories = ['mailbox']
  for m in mandatories:
    if not options.__dict__[m]:
      print "mandatory option " + m + " is missing\n"
      p.print_help()
      exit(1)

  #the main action

if __name__ == '__main__':
  main()
