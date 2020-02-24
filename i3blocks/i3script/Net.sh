#!/bin/bash
ping -c 1 baidu.com > /dev/null 2>&1
if [ $? -eq 0 ];then
	echo "y"
fi
