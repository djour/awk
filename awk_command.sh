# awk command test
# !/bin/bash
# $1 : netstat.txt
# $2 : /etc/passwd
# $3 : score.txt

# 载入变量
for arg in "$*"
do
    echo $arg
done 

for arg in "$@"
do 
    echo $arg
done

# 脱掉外套
awk '{print $1, $4}' $1
awk ' $3 > 0 {print $0}' $1
awk ' $3 > 0 && $6=="LISTEN" ' $1
awk ' $3 > 0 && $6=="LISTEN" || NR ==1' $1
awk ' $3 > 0 && $6=="LISTEN" || NR ==1 {printf "%-20s %-20s %s\n", $4, $5, $6}' $1

## 内建变量
awk '{==0 && $6=="ESTABLISHED" || NR==1 {printf "%02s %s %-20s %-20s %s\n",NR, FNR, {}
,$5,$6}' $1

## 指定分隔符
awk  'BEGIN{FS=":"} {print $1,$3,$6}' $2
awk  -F: '{print $1,$3,$6}' $2
awk -F '[;:]'
awk  -F: '{print $1,$3,$6}' OFS="\t" $2

# 脱掉衬衫
# 字符串匹配
awk '$6 ~ /FIN/ || NR == 1 {print NR, $4, $5, $6}' OFS="\t" $1
awk '$6 ~ /WAIT/ || NR == 1 {print NR, $4, $5, $6}' OFS="\t" $1

awk '/LISTEN/' $1

awk '$6 ~ /FINTIME/ || NR == 1 {print NR, $4, $5, $6}' OFS="\t" $1
awk '$6 !~ /WAIT/ || NR == 1 {print NR, $4, $5, $6}' OFS="\t" $1

awk '!/WAIT/' $1

# 拆分文件
awk 'NR!=1{print > $6}' $1 #不处理表头NR!=1
ls
cat ESTABLISHED
cat FIN_WAIT1
cat LISTEN

# 统计
## 计算所有的C文件，CPP文件和H文件的文件大小总和
ls -l *.cpp *.c *.h | awk '{sum+=5} END {print sum}'

## 统计各个connection状态的用法
awk 'NR!=1{a[$6]++;} END {for (i in a) print i ", " a[i];}' $1

## 统计每个用户的进程占了多少内存
ps aux | awk 'NR!=1{a[$1]+=$6;} END {for (i in a) print i ", " a[i]"KB";}'

# 脱掉内衣
## 参考 cal.awk 文件
## 简单的统计计算和表格整理输出
cat $3
awk -f cal.awk $3
chmod 777 cal.awk
./cal.awk $3

## 环境变量
export x='5'
export y='10'
echo $x $y
awk -v val=$x '{print $1, $2, $3, $4+val, $5+val}' OFS='\t' $3
awk -v val1=$x val2=$y'{print $1, $2, $3, $4+val1, $5+val2}' OFS='\t' $3
awk '{print $1, $2, $3, $4+ENVIRON["x"], $5+ENVIRON["y"]}' OFS='\t' $3

# 几个花活
## 从文件里找出长度大于80的行
awk 'length>80' $1
## 在netstat.txt里按连接数查看客户端IP
netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr
## 打印99乘法表
seq 9 | sed 'H;g' | awk -v RS='' '{for(i=1;i<=NF;i++)printf("%dx%d=%d%s", i , NR, i*NR, i==NR?"\n":"\t")}'
