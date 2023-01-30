#!/bin/bash
# inpath -- 验证指定程序是否可执行，能否在PATH目录列表中找到。

in_path()
## 定义函数in_path
{
    # 尝试在环境变量PATH中找到给定的命令。如果找到，返回0；如果没有找到，则返回1。注意，该函数会临时修改IFS（内部字段分隔符），不过在函数执行完毕时会将其恢复原状。
      cmd=$1       # 提供要查找的命令，从输入的第一个变量获取
      ourpath=$2   # 提供查找命令的指定路径，从输入的第二个变量获取
      result=1     # 定义返回结果变量的初值
      oldIFS=$IFS  # 将默认的分隔符IFS保存在oldIFS变量中
      IFS=":"      # 将IFS修改为以“：”进行分割
      for directory in “$ourpath”  #对用户提供的路径列表，逐一取值并进行命令是否可执行的判断。判断为真，则返回result=0
          do
              if [ -x $directory/$cmd ] ; then
                  result=0      # if we're here, we found $cmd in $directory
              fi
          done

      IFS=$oldIFS       #将IFS恢复成默认的分隔符
      return $result    #函数返回result的值
}

checkForCmdInPath()
## 定义函数checkForCmdInPath
{
    var=$1  # 对变量var赋值

    if [ "$var" != "" ] ; then
    # 逻辑如下：
    # 判断var变量的值是否为空；如果不为空，则继续判断var变量中是否包含路径；如果不包含路径，则判断var中是一个命令；此时判断var中的命令是否可执行，如果不可执行，则返回1
    # 在PATH路径下检查这个命令是否可执行，；或者调用函数in_path判断这个命令是否在PATH路径下,
        if [ "${var:0:1}" = "/" ] ; then
            if [ ! -x $var ] ; then
                return 1
            fi
        elif !  in_path $var "$PATH" ; then
            return 2
        fi
    fi
}

# 判断执行脚本时，输入的参数个数。如果参数个位不为1，则报错并告知使用格式，接着退出。
if [ $# -ne 1 ] ; then
   echo "你输入的参数个数不对！Usage: $0 command" >&2 ; exit 1
fi

# 主程序，对输入的命令进行判断，根据命令查询结果返回不同的值
checkForCmdInPath "$1"

# 对主程序的返回值进行判断，根据返回值进行打印不同的提示。
case $? in
  0 ) echo "$1 found in PATH"                   ;;
  1 ) echo "$1 not found or not executable"     ;;
  2 ) echo "$1 not found in PATH"               ;;
esac
exit 0
