#!/bin/bash

project_name=$1

#echo $project_name

project_path=$2

#echo $project_path

mkdir $project_path/$project_name

mkdir $project_path/$project_name/1_sequences $project_path/$project_name/2_results $project_path/$project_name/3_output_files $project_path/$project_name/4_log_files $project_path/$project_name/5_error_files

echo Directory structure generated succesfully at \"$project_path/$project_name\".
