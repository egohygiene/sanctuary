#!/usr/bin/env bash

# https://manpages.ubuntu.com/manpages/bionic/man1/inxi.1.html 

# Check for root privilages
if [[ $EUID -ne 0 ]]; then
    echo "run the ${!#} as root"
    exit 1
fi

# Save computer information to a file. 
inxi -Frsmxz | tee computer_info.log 

soffice --convert-to pdf --outdir docs computer_info.log

rm computer_info.log
