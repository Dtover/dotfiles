#!/bin/bash
linenumber=$[$RANDOM%100]
ln=$(cat ~/Documents/hitokoto/jinrishici/jinrishici.md | wc -l)
until [[ $linenumber -gt 0 && $linenumber -le $ln ]]
do
	linenumber=$[$RANDOM%100]
done
cat ~/Documents/hitokoto/jinrishici/jinrishici.md | sed -n $linenumber'p'
