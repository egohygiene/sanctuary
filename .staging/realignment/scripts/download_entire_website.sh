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
${URL}
