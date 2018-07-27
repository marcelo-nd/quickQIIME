#!/bin/bash

project_path=$1

# Create project directory
mkdir $project_path

# Create directories for results and various logs
mkdir $project_path/1_sequences $project_path/2_results $project_path/3_output_files $project_path/4_log_files $project_path/5_error_files $project_path/6_databases $project_path/tmp

TMPDIR=$project_path/tmp

echo Directory structure generated succesfully at \"$project_path\".
