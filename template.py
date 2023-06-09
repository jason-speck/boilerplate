#!/usr/bin/python
import click
import logging
import shlex
import os
import subprocess


@click.command()
@click.option('-o','--option',metavar="OPTION VALUE",required=False,default="some default",help="what this option does")
@click.option('-f','--flag',is_flag=True,required=False,default=False,help="what this flag does")
@click.option("--debug", is_flag=True, help="Turn on debug output")
@click.option('--logfile',metavar="FILE",default=None,help="Send debug output to file instead of stderr")
@click.option('-V','--version','version_flag', is_flag=True, default=False,help="print the version and exit")
def main(option, flag, debug, logfile, version_flag):
    version="0.0.1"


    if version_flag:
        print ("%s %s" % ( os.path.basename(__file__), version ))
        exit()

    if debug:
        logging.basicConfig(filename=logfile,format='%(asctime)s %(levelname)s %(message)s',
                            level=logging.DEBUG)
        logging.debug("Debug logging turned on")
        logging.debug( "%s %s" % (os.path.basename(__file__), version ))
    else:
        logging.basicConfig(filename=logfile,format='%(asctime)s %(levelname)s %(message)s',
                            level=logging.WARNING)

    do_cmd("/usr/bin/pwd")


def do_cmd(cmd):
    splitcmd=shlex.split(cmd)
    logging.info("Running command: %s" % splitcmd)
    try:
        cmd_out=subprocess.run(splitcmd)
    except:
        print ("couldn't execute command: %s" % cmd)
        exit(1)
    return cmd_out


if __name__ == '__main__':
  main()
