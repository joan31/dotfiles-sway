#!/bin/env bash
echo "$BASH_SOURCE"
ls
full_path="$(realpath "$BASH_SOURCE")"
echo "$full_path"
dir_path="$(dirname "$full_path")"
echo "$dir_path"
examples="$(dirname "$dir_path")"
echo "$examples"
data_dir=""$examples"/data"
echo "DATA: "$data_dir""
