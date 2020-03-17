#!/bin/bash
linenumber=$[$RANDOM%100]
ln=$(cat ~/Documents/sentence/jinrishici/jinrishici_collection.md | wc -l)
until [[ $linenumber -gt 0 && $linenumber -le $ln ]]
do
	linenumber=$[$RANDOM%100]
done
sentence=$(cat ~/Documents/sentence/jinrishici/jinrishici_collection.md | sed -n $linenumber'p')
echo $sentence
