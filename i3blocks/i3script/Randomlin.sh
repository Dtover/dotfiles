#!/bin/bash
linenumber=$[$RANDOM%100]
ln=$(cat ~/Documents/hitokoto/hitokoto_collection.md | wc -l)
until [[ $linenumber -gt 0 && $linenumber -le $ln && $(expr $linenumber % 2) -eq 0 ]]
do
	linenumber=$[$RANDOM%100]
done
cat ~/Documents/hitokoto/hitokoto_collection.md | sed -n $linenumber'p'
