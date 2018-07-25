#!/bin/bash

echo Type project name \(no spaces\).

read project_name

echo Enter path.

read project_path

#echo project_path

# Execute script for generating folder structure.

echo Generating directory structure for project \"$project_name\".

./0_scripts/0_generateDirectoryStructure.sh $project_name $project_path

#IMPLEMENT LATER

# Execute script for generating manifest file.

# echo Generating manifest file

# ./0_scripts/1_manifestGenerator.sh

# 

# Read user input for workflow selection.
