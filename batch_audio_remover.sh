#!/bin/bash

# Purpose - removing audio from multiple files in a folder
# TBD - selection of tracks with language name and not by track id. In the existing case track id is an input which is found by using mkvinfo.
# Use the script carefully - I ran the program over a file to remove track X but the file did not have audio track X. It deleted the only track which was avaialble.

# verification of the command & default header message
if [ $# -ne 3 ]
then
    echo "Usage: ./batch_audio_remover.sh <directory_path> <track_id_to_be_removed> <suffix_for_output_file>"
else
    directory=$1 
    track_id=$2
    suffix=$3
fi

# dependency check
if type mkvmerge &> /dev/null
then
    echo "Depedency check: mkvmerge found. proceeding ahead.."
else
    echo "Error: mkvmerge not installed or not added in the PATH"
    exit
fi

file_list=( $(ls $1) )

# looping through file names
for fname in ${file_list[@]}
do

    if [ ${fname:${#fname}-3:${#fname}} != "mkv" ]
    then
	echo "Incorrect File Extension:" $fname
	exit
    else
	fout=${fname:0:${#fname}-4}"_$3.mkv"
	mkvmerge -o $directory/$fout -a $2 $directory/$fname
    fi
done


    
 
