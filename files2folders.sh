#!/bin/bash

#This is to take movie files and put them in a folder and any files that go along with them ex: subtitle files

#user input for the directory
echo "Enter directory: "
read dir
echo "What file type do you want to search for?"
read filetype

#search that directory for files
search=`find "$dir" -maxdepth 1 -type f -name *.$filetype`


SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for var in $search
do
	path="${var%/*}"
	extensionname="$(basename $var)"
	name="${extensionname%.*}"

#making the new directory
	`mkdir -v $dir/$name`

#placing any files that have the movie's name in it in the directory
	#new search for anything else that has the name of the movie in it
	extras=`find "$dir" -maxdepth 1 -type f -name "$name"*`
	for x in $extras
	do
		`mv -v "$x" "$dir/$name/"`
	done

done
IFS=$SAVEIFS
