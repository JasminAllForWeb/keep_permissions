#!/bin/bash

echo "Keep permissions ON";
function regex1 { gawk 'match($0,/'$1'/, ary) {print ary['${2:-'1'}']}'; }

while true; do

inotifywait -e modify,create,delete,move -r $1 |
	while read -r path; do
		if [[ $path =~ ((.+)client_(.+))\/( [A-Z]+ (.+)) ]]; then 
			root_path=${BASH_REMATCH[1]}
			username=${BASH_REMATCH[3]}
			f=${BASH_REMATCH[5]}
			full_path="$root_path/$f"
  			echo "The full path is '$full_path'." >> ~/log_deploy
  			echo "The root path is '$root_path'." >> ~/log_deploy
  			echo "The folder/file is '$f'." >> ~/log_deploy
  			echo "The user is '$username'." >> ~/log_deploy
  			command="sudo chown -R www-data:$username $full_path"
  			echo $command >> ~/log_deploy
  			`$command`>> ~/log_deploy
		else
			echo "ERROR User not detected with '$path'" >> ~/log_deploy
		fi
	done
done

