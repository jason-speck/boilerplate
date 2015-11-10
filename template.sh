#!/bin/bash

# $Id: $
# $DateTime: $
# $Author: $
#SET UP ENVIRONMENT
script_name=`basename $0`

##FUNCTIONS

function dprint () {
  if [[ $DEBUG ]]; then
    echo $*
  fi
}

function print_usage() {
  echo "Usage: $script_name " >&2
  echo "Options:"
  echo
  echo "    -d   debug mode"
  echo "    -h   shows this message."
}

##MAIN
#check options
while getopts :dh opt
do
  case $opt in
  #
  #this shows how to use OPTARG
  # f)    filesystem_flag=true
  #      filesystem=$OPTARG
  #;;
  d)    DEBUG=true
  ;;
  h)    print_usage;
        exit
  ;;
  '?')  echo "$script_name: invalid option -$OPTARG" >&2
        print_usage;
        exit 1
  ;;
  esac
done

shift $((OPTIND-1))

