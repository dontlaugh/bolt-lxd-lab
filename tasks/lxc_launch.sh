#!/bin/sh

image=$PT_image
name=$PT_name
optional_args=$PT_args

# redirect stderr, because bolt only displays a single stream
lxc launch $image $name $optional_args 2>&1
