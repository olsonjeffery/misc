#!/bin/sh
# cs ../dir *.ext 'pattern'
find $1 -name '$2' -exec grep $3 -H -n {} \;
