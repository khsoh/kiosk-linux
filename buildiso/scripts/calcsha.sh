#!/bin/sh

# TO BE RUN WITHIN THE DIRECTORY COPIED FROM THE MOUNTED ISO IMAGE
find . -type f -print0 | sort -z | xargs -r0 sha256sum 

