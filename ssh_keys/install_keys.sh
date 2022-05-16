#!/bin/bash

# DO NOT run with sudo priviliges
if [[ $EUID -eq 0 ]]; then
  echo "This script must NOT be run as root. Exiting" 1>&2
  exit 1
fi

HOME_PATH="/home/$(logname)"

cd $HOME_PATH
ssh-keygen -t rsa -b 4096 -C "your-name@mail.com"

eval "$(ssh-agent -s)"

ssh-add $HOME_PATH/.ssh/id_rsa

echo "
THIS IS YOUR PUBLIC KEY, Copy it into github:
"

cat $HOME_PATH/.ssh/id_rsa.pub