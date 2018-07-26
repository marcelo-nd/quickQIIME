#!/bin/bash

echo Type project name \(no spaces\).

read project_name

echo Enter path.

read user_path

################ 0 Execute script for generating folder structure. ###############

project_path=$user_path/$project_name

echo Generating directory structure for project \"$project_name\".

#
./0_scripts/0_generateDirectoryStructure.sh $project_path
#

############### 1 Execute script for generating manifest file. ###############
#IMPLEMENT LATER

# echo Generating manifest file

# ./0_scripts/1_manifestGenerator.sh

# 

############### 2 Read user input for workflow selection. ###############
#IMPLEMENT LATER

############### 2 User selection of patung ###############

# Initial value of in_patung variable
in_patung=xxx

until [ $in_patung = y ] || [ $in_patung = n ]
do
    echo Patung \(y or n\) /?
    read in_patung
    #echo in_patung
done

################ 2 Generate executable files ###############

echo Generating executable files

./0_scripts/2_generate_executables.sh $project_path

############### 2 Generate condor files ###############

if [ $in_patung = y ]
    then
    echo Generating condor files
    
    ./0_scripts/0_generate_condor_files.sh $project_name $project_path
fi

chmod +xrw -R 0_scripts/


############################ Executing QIIME ############################

############## 2_Import sequences to qiime format. ##############

if [ $in_patung = y ]
    then
    echo Executing QIIME in patung.
    #condor_sumbit ./0_scripts/2_import_sequences.condor

    #./2_import_sequences.condor
elif [ $in_patung = n ]
    then 
    echo Executing QIIME locally.
    #./0_scripts/2_import_sequences.sh $project_name $project_path
    #2_import_sequences.sh
fi
