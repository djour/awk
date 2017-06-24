#!/usr/bin/bash

# 1. pets.txt
# 2. html.txt
# 3. my.txt
# 4. t.txt

# 用s命令替换,s／替换，／g替换所有的匹配
sed "s/my/Hao Chen's/g" $1

sed "s/my/Hao Chen's/g" $1 > hao_pets.txt

# 直接修改文件内容
sed -i "s/Hao Chen's/Ming Wang's/g" hao_pets.txt

# 在每一行最前面加点东西
sed 's/^/#/g' $1

# 在每一行最后加点东西
sed 's/$/ --- /g' $1

# 指定要替换的内容
## 指定替换第三行的my
sed '3s/my/your/g' $1

## 指定替换第3-6行的my
sed '3,6s/my/your/g' $1

## 只替换每一行的第一个s
sed 's/s/S/1' $3

## 只替换每一行的第二个s
sed 's/s/S/1' $3

## 只替换每一行第三个之后的s
sed 's/s/S/3g' $3

# ------------
# 多个匹配
## 第一行到第三行的my替换成your；第三行以后的This替换成That
sed '1,3s/my/your/g; 3,$s/This/That/g' $3

sed -e '1,3s/my/your/g' -e '3,$s/This/That/g' $3

## 在被替换的东西左右加点东西
sed 's/my/[&]/g' $3

# 圆括号匹配
## 圆括号扩起来的正则表达式所匹配的字符串可以当成变量来使用，sed中使用的是\1,\2,...
sed 's/This is my \([^,]*\),.*is \(.*\)/\1:\2/g' $3

# 正则为：This is my ([^,]*),.*is (.*)
# 匹配为：This is my (cat),……….is (betty)
# 然后：\1就是cat，\2就是betty

# --------------------
# N命令
# 把原文中的偶数行纳入奇数行匹配，而s只匹配并替换一次 (两行作一行)
sed 'N;s/my/your/' $1

sed 'N;s/\n/,/' $1
#--------------------
# a命令和i命令, 添加行
# a : append
# i : insert
sed "1 i This is my monkey, my monkey's name is wukong" $1
sed "$ a This is my monkey, my monkey's name is wukong" $1
# 匹配到/fish/后就追加一行
sed "/fish/a This is my monkey, my monkey's name is wukong" $1
# 对每一行都插入
sed "/my/a ----" $1

# -------------------
# c命令
# 替换匹配行
sed "2 c This is my monkey, my monkey's name is wukong" $1

sed "/fish/c This is my monkey, my monkey's name is wukong" $1

# -------------------
# d命令
# 删除匹配行
sed '/fish/d' $1

sed '2d' $1

sed '2,$d' $1

# -------------------
# p命令
# 打印命令
# 可以当作grep命令

# 匹配fish并输出，会把匹配到的内容打印两遍
sed '/fish/p' $1

# 用n参数来避免重复打印两遍的问题
sed -n '/fish/p' $1

#  从一个模式到另一个模式(既匹配dog，又匹配fish)
sed -n '/dog/, /fish/p' $1

# 从第一行打印到匹配fish成功的那一行为止
sed -n '1,/fish/p' $1


# 四个知识点
## 1. Pattern Space: sed的具体实现伪代码可以解释为什么 －n可以避免重复输出
## 2. Address: [address[,address]][!]{cmd}, 一个起始条件，一个终止条件
### 对第一次匹配成功后的连续三行都执行这个指令
sed '' '/dog/,+3s/^/# /g' $1
## 3. 命令打包：第二个cmd可以是一条，也可以是多个，用；分开，｛｝做嵌套
cat $1
sed '' '3,6 {/This/d}' $1
### 匹配this成功后，在匹配fish，全部成功后再执行cmd
sed '' '3,6 {/This/{/fish/d}}' $1

### 从第一行到最后一行，如果匹配到This，则删除之；如果前面有空格，则去处空格
sed '' '1,$ {/This/d;s/^  *//g}' $1

## 4. Hold Space: 
# g: 把hold space里的内容copy到pattern space里
# G: 把hold space里的内容append到pattern space\n 之后
# h: 把pattern space里的内容copy到hold space中，原来的hold space里内容被清除
# H: 把pattern space里的内容append到hold space\n 之后
# x: 交换pattern space和hold space的内容

# -------------------------------#
# {Pattern Space} + {Hold Space} #
# -------------------------------#
cat $4

# 叠加
sed 'H;g' $4

# 反序(三个pattern用分号串联)
# 1!G —— 只有第一行不执行G命令，将hold space中的内容append回到pattern space
# h —— 每一行都执行h命令，将pattern space中的内容拷贝到hold space中
# $!d —— 除了最后一行不执行d命令，其它行都执行d命令，删除当前行（控制流程不让中间结果输出）
sed '1!G;h;$!d' $4

# 叠加的另一种表达
# sed 'H;$!d' $4


# --------------------

## 正则表达式基础
# ^ : 一行开头
# $ ：一行结尾
# \< ：词首，\<abc,以abc为首的词
# \< ： 词尾，abc\<, 以abc为结尾的词
# . ： 任何单个字符
# * : 某个字符出现了0次或多次
# ［］：字符集合。[abc] 匹配a或b或c，［a-zA-Z］匹配所有26个字符
# [^a]: 非a的字符集合

# 去掉某html种的tags：
sed 's/<.*//g' $2
## 改进
sed 's/<[^>]*>//g' $2


