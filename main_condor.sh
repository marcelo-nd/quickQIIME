#!/bin/bash

################ Variables. ###############

user_files_path=$1

user_path=$2

project_name=$3

# workflow_id=$4

# project path variable
project_path=$user_path/$project_name

################ 0 Execute script for generating folder structure. ###############

echo Generating directory structure for project \"$project_name\".

#
./0_scripts/0_generateDirectoryStructure.sh $project_path
#

# Copying user files

echo Copying files to $project_path/1_sequences/

cp -R user_files_path/. $project_path/1_sequences/

# Descargar bases de datos.

wget -P project_path/6_databases/ https://data.qiime2.org/2018.6/common/gg-13-8-99-nb-classifier.qza

wget -P project_path/6_databases/ https://data.qiime2.org/2018.6/common/silva-132-99-nb-classifier.qza

# Sourcing qiime2
# source /srv/home/anavarro/miniconda3/bin/activate qiime2

# Exporting TEMPDIR

#export TMPDIR=$project_path/tmp

# Step 1 Importing sequences.

# echo Importing sequences

# qiime tools import \
# --type 'SampleData[PairedEndSequencesWithQuality]' \
# --input-path $project_path/1_sequences/ \
# --source-format PairedEndFastqManifestPhred33 \
# --output-path $project_path/2_results/1_demultiplexed_pairedEnd_seqs.qza \
