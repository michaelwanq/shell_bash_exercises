#!/bin/bash
# nicenumber--Given a number, shows it in comma-separated form.
#   Expects DD (decimal point delimiter) and TD (thousands delimiter)
#   to be instantiated. Instantiates nicenum or, if a second arg is
#   specified, the output is echoed to stdout.
# 对用户输入的数字进行千分位标识，方便用户读数。
# nicenumber -- 将给定的数字以逗号分隔的形式显示出来。可接受两个选项：DD（decimal point delimiter，小数分隔符）和TD（thousands delimiter，千位分隔符）。
nicenumber()
{
  # Note that we assume that '.' is the decimal separator in
  #   the INPUT value to this script. The decimal separator in the output
  #   value is '.' unless specified by the user with the -d flag.

  integer=$(echo $1 | cut -d"." -f1)        # left of the decimal
  decimal=$(echo $1 | cut -d"." -f2)        # right of the decimal

  # Check if our number has more than just the integer part.
  if [ “$decimal” != “$1” ]; then
    # There's a fractional part, so let's include it.
    result="${DD:= '.'}$decimal"
  fi

  thousands=$integer

  while [ $thousands -gt 999 ]; do
    remainder=$(($thousands % 1000))    # three least significant digits

    # We need ‘remainder’ to be three digits. Do we need to add zeroes?
    while [ ${#remainder} -lt 3 ] ; do  # Force leading zeros
      remainder="0$remainder"
    done

    result="${TD:=","}${remainder}${result}"    # Builds right to left
    thousands=$(($thousands / 1000))    # To left of remainder, if any
  done

  nicenum="${thousands}${result}"
  if [ ! -z $2 ] ; then
    echo $nicenum
  fi
}

DD="."  # Decimal point delimiter to separate whole and fractional values
TD=","  # Thousands delimiter, to separate every three digits

# BEGIN MAIN SCRIPT
# =================

while getopts "d:t:" opt; do
  case $opt in
    d ) DD="$OPTARG"    ;;
    t ) TD="$OPTARG"    ;;
  esac
done
shift $(($OPTIND - 1))

# Input validation
if [ $# -eq 0 ] ; then
  echo "Usage: $(basename $0) [-d c] [-t c] numeric_value"
  echo "  -d specifies the decimal point delimiter (default '.')"
  echo "  -t specifies the thousands delimiter (default ',')"
  exit 0
fi

nicenumber $1 1         # Second arg forces nicenumber to 'echo' output.

exit 0
