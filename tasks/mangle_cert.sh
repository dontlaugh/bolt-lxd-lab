#!/bin/sh

# We process a PEM-encoded cert (with newlines) into something suitable for 
# embedding within yaml

mangled=$(sed ':a;N;$!ba;s/\n/\n\n/g' $PT_cert_path)

# We print json to stdout for easy use in Bolt plans
echo -n "{ \"cert\": \"${mangled}\"}"
