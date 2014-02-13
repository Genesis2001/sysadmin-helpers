#!/bin/bash

input()
{
	read -p "$1" result
	echo $result
}


DOMAIN=$(input "Domain: ")

while [ true ]; do
	USER=$(input "User: ")
	
	if [[ ! -z $USER ]]; then
		break
	fi
done

usercheck=$(getent passwd | grep -c "^$USER:")
if [[ $usercheck -eq 0 ]]; then 
	echo "User does not exist."
	exit 1
fi

result=$(input "Will this user host multiple websites off this server? [y] ")

loc=$(dirname $0)
file="${loc}/nginx_example.conf"
if [ "$result" == "n" ]; then
	file="${loc}/nginx_example_single.conf"
fi

CONFIG=${DOMAIN%%.*}
cat $file > "$CONFIG.conf"

sed -i -e "s/\${USER}/$USER/" -e "s/\${DOMAIN}/$DOMAIN/" "$CONFIG.conf"

exit 0
