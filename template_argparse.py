#!/usr/bin/python
import argparse
import logging

def main():
    parser = argparse.ArgumentParser(description="program description")
    ##action is what to do.  
    ##dest is the attribute of the parse_args() output
    ##default is the default value
    ##choices are the valid values
    ##required is boolean
    ##help is text that appears on usage output


    parser.add_argument("--debug",action="store_true",dest="debug",help="Turn on debug output")
    #example of an option
    #parser.add_argument("-c","--config",action="store",metavar="PM CONFIG FILE",dest="config",help="PM configuration file if you want to use other than the default database")
    #see ilt for how to implement subcommands
    #see cadence reporter script p4logparse.py for how to process files. use fileinput

    results = parser.parse_args()

    if results.debug:
        logging.basicConfig(format='%(levelname)s:%(message)s',level=logging.DEBUG)
        logging.debug ("Debug output turned on")



if __name__ == '__main__':
  main()
