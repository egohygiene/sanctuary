#!/usr/bin/env bash

URL=${1}

# Download an entire website.
wget \
--random-wait \
--recursive \
--page-requisites \
--execute robots=off \
--user-agent "$(randomua --desktop-browser)" \
--directory-prefix sites \
${website}



# Save an HTML page, and covert it to a .pdf file
wget ${URL} | htmldoc --webpage -f "$URL".pdf - ; xpdf "$URL".pdf &
