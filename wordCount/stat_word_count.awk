#!/bin/awk -f

# Input:
# word1 1
# word2 10


BEGIN {
    dict = 0
    printf "WORD    NUMBER\n"
    printf "--------------\n"
}
{
    words +=1
    dict += $2
    printf "%-6s %-8d\n", $1, $2
}
END {
    printf "--------------\n"
    printf "NUMBER of UNIQUE WORDS: %10d\n", words
    printf "TOTAL NUMBER of WORDS: %10d\n", dict
}
