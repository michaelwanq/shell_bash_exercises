#!/bin/bash
# 对用户提供的输入进行判断，输入只包含数字、字母的大小写形式，不包括标点符号和特殊字符！
validAlphaNum()
# 定义函数validAlphaNum，对用户输入进行检查
{
  # 将用户输入进行处理，结果赋值给变量validchars。如果和用户输入一致，返回值为0；如果不一致，则返回值为1。
  validchars="$(echo $1 | sed -e 's/[^[:alnum:]]//g')"

  if [ "$validchars" = "$1" ] ; then
    return 0
  else
    return 1
  fi
}

# BEGIN MAIN SCRIPT-–DELETE EVERYTHING BELOW THIS LINE IF YOU
#   WANT TO INCLUDE THIS IN OTHER SCRIPTS.
# =================
#/bin/echo -n "Enter input: "
echo -n "Enter input: "
read input
# 运行脚本时获取用户想要判断的值

# Input validation
# 主函数，调用函数validAlphaNum对输入的变量input进行判断，如果不一致，则提示并退出，状态码为1；如果一致，则提示并退出，状态码为0
if ! validAlphaNum "$input" ; then
    echo "Your input must consist of only letters and numbers." >&2
    exit 1
else
    echo "Input is valid."
fi

exit 0
