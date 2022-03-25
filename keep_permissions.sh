#!/bin/bash

function regex1 { gawk 'match($0,/'$1'/, ary) {print ary['${2:-'1'}']}'; }

while true; do

inotifywait -e modify,create,delete,move -r $1 |
	while read -r path; do
		#dir=$(git rev-parse --show-toplevel)
		#username=$dir | regex1 '.+client_(.+)'
		#chown -R www-data:$username $dir
		echo $path >> ~/log_deploy
		echo $username >> ~/log_deploy
	done
done

