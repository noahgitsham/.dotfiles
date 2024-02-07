#!/usr/bin/sh

echo "Public:  $(curl -s icanhazip.com)"
echo "Private: $(hostname -i)"
