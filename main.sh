#!/bin/bash

echo Type project name \(no spaces\).

read project_name

echo Enter path.

read project_path

#echo project_path

# Execute script for generating folder structure.

echo Generating directory structure for project \"$project_name\".

#
#./0_scripts/0_generateDirectoryStructure.sh $project_name $project_path
#


# Execute script for generating manifest file.
#IMPLEMENT LATER

# echo Generating manifest file

# ./0_scripts/1_manifestGenerator.sh

# 

# Read user input for workflow selection.
#IMPLEMENT LATER

# 2_Import sequences to qiime format.

in_patung=xxx

#echo $in_patung

until [ $in_patung = y ] || [ $in_patung = n ]
do
    echo Patung \(y or n\) /?
    read in_patung
    #echo in_patung
done

if [ $in_patung = y ]
    then
    echo Executing condor files.
    #./2_import_sequences.condor
elif [ $in_patung = n ]
    then 
    echo Executing locally.
    #2_import_sequences.sh
fi