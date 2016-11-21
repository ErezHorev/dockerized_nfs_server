#!/bin/bash
set -e

cur_dir=${PWD##*/}
cur_name=`basename "$0"`
echo $cur_dir/$cur_name
cd ..

msg="# This file lists all contributers to the repository.\n# For how it is generated, see:"
{
echo -e $msg $cur_dir/$cur_name
echo
git log --format='%aN <%aE>' | LC_ALL=C.UTF-8 sort -uf
} > AUTHORS
