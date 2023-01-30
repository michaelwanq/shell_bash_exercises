#!/bin/bash
# 将用户输入的日期格式进行标准格式化示例
monthNumToName()
{
 # Sets the variable 'month' to the appropriate value.
  case $1 in
    1 ) month="Jan"
    ;; 
    2 ) month="Feb"
    ;;
    3 ) month="Mar"
    ;; 
    4 ) month="Apr"
    ;;
    5 ) month="May"
    ;; 
    6 ) month="Jun"
    ;;
    7 ) month="Jul"
    ;; 
    8 ) month="Aug"
    ;;
    9 ) month="Sep"
    ;; 
    10) month="Oct"
    ;;
    11) month="Nov"
    ;;
    12) month="Dec"
    ;;
    * ) echo "$0: Unknown numeric month value $1" >&2
    exit 1
  esac
  return 0
}

# BEGIN MAIN SCRIPT鈥?DELETE BELOW THIS LINE IF YOU WANT TO 
#   INCLUDE THIS IN OTHER SCRIPTS.
# =================
# Input validation
# 将用户输入的**-**-****或者**/**/****转化为** ** ****的标准输入格式
if [ $# -eq 1 ] ; then
   set -- $(echo $1 | sed 's/[\/\-]/ /g')
fi
if [ $# -ne 3 ] ; then
  echo "Usage: $0 month day year" >&2
  echo "Formats are August 3 1962 and 8 3 1962" >&2
  exit 1
fi
if [ $3 -le 99 ] ; then	
  echo "$0: expected 4-digit year value." >&2; exit 1
fi

# Is the month input format a number?
if [ -z $(echo $1|sed 's/[[:digit:]]//g')  ]; then
  monthNumToName $1
else
# Normalize to first three letters, first upper-, rest lowercase.
  month="$(echo $1|cut -c1|tr '[:lower:]' '[:upper:]')"
  month="$month$(echo $1|cut -c2-3 | tr '[:upper:]' '[:lower:]')"
fi

echo $month $2 $3

exit 0
