#!/usr/bin/env bash

clfavs() {
	URL="http://www.commandlinefu.com"
	wget -O - --save-cookies c --post-data "username=$1&password=$2&submit=Let+me+in" $URL/users/signin
	for i in $(seq 0 25 $3); do wget -O - --load-cookies c $URL/commands/favourites/plaintext/$i >>$4; done
	rm -f c
}

clfavs
