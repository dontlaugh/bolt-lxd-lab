#!/bin/sh

image=$PT_image
name=$PT_name

lxc launch $image $name
