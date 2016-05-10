#!/usr/bin/python
import argparse
import logging
import MySQLdb
import os

def main():
    version="0.1.0"
    parser = argparse.ArgumentParser(description="MySQL template program")

    parser.add_argument("--debug",action="store_true",dest="debug",help="Turn on debug output")
    parser.add_argument('--logfile',metavar="FILE",default=None,help="Send debug output to file instead of stderr",dest="logfile")
    parser.add_argument('-V','--version', default=False, action="store_true", help="print the version and exit",dest="version")

    options = parser.parse_args()

    dbhost="localhost"
    dbuser="icmAdmin"
    dbpass="icmAdmin"

    if options.debug:
        logging.basicConfig(filename=options.logfile,format='%(asctime)s %(levelname)s %(message)s',
                            level=logging.DEBUG)
        logging.debug("Debug logging turned on")
        logging.debug( "%s %s" % (os.path.basename(__file__), version ))
    else:
        logging.basicConfig(filename=options.logfile,format='%(asctime)s %(levelname)s %(message)s',
                            level=logging.WARNING)

    #create a test db
    con=MySQLdb.connect(host=dbhost,
                       user=dbuser,
                       passwd=dbpass)

    cur=con.cursor()
    con.close()

def doquery(cur,stmt,role="SQL"):
    logging.debug("%s: %s" % (role,stmt));
    cur.execute(stmt)


if __name__ == '__main__':
  main()
