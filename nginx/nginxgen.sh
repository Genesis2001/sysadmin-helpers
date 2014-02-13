#!/bin/sh

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

if [ "$result" == "n" ]; then
	# ffffx
else
	# ffffy
fi

exit 0
