#!/usr/bin/bash

# chmod 777 word_count.sh | ./wordcount.sh pets.txt
# bash无法找到
# 原因： which bash
# /bin/bash
# sed "s/\/usr//g" word_count.sh 

# Word count
# with a single pipeline
cat $1 | tr -s ' ' '\n' | sort | uniq -c | sort -r | awk '{print $2,$1]}'
