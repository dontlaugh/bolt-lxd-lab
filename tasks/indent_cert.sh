#!/bin/sh

# We prepend 4 spaces to every line in our PEM-encoded cert, such that the
# vengeful and jealous YAML god is satisfied.

# We access our task parameter with env vars prefixed with $PT_
cat $PT_cert_path | awk '{ print "    " $0 }'
