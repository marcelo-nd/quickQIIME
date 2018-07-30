#!/bin/bash

echo Type project name \(no spaces\).

read project_name

echo Enter full path.

read user_path

############### 0 User selection of patung ###############

# Initial value of in_patung variable
in_patung=xxx

until [ $in_patung = y ] || [ $in_patung = n ]
do
    echo Patung \(y or n\) /?
    read in_patung
    #echo in_patung
done

################ 0 Execute script for generating folder structure. ###############

# project path variable
project_path=$user_path/$project_name

# Checking if directory with the same name exists.

if [ -d "$project_path" ]; then
  # Control will enter here if $DIRECTORY exists.
  echo Directory already exists; please change the name of old directory and press enter.
  read -p "Press enter to continue"
fi

echo Generating directory structure for project \"$project_name\".

#
./0_scripts/0_generateDirectoryStructure.sh $project_path
#


# Copying user files

echo Enter full path for you files.

read user_files_path

echo Copying files to $project_path/1_sequences/

cp -R user_files_path/. $project_path/1_sequences/


############### 1 Asking for manifest file. ###############

manifest="_manifest.txt"

# Check if manifest files exists; if not ask the user to copy it.

until [ -e "$project_name $manifest" ]
            then
                echo "Manifest file found!"
            else
                echo "Manifest files not found; please paste it at 1_sequences directory and press enter"

                read -p "Press enter to continue"

            fi 


############### 2 Read user input for workflow selection. ###############
#IMPLEMENT LATER

workflow_id=999

until [ $workflow_id = 1 ] || [ $workflow_id = 2 ] || [ $workflow_id = 3 ]
do
    echo Workflow selection \(1: greengenes; 2: greengenes + refSeq; 3: greengenes + SILVA\) /?
    read workflow_id
    #echo in_patung
done


# Revisar si existe la base de datos o descargarla si es necesario.

    if [ $in_patung = n ]
        then
        
            echo If you already dowloaded greengrenes database paste it to path/6_databases and press Enter.\n
            echo Else, just press enter to download it\n
            read -p "Press enter to continue"

            if [ -e ! 6_databases/gg-13-8-99-nb-classifier.qza ]
            then
                echo "Greengenes 13-8 database found!"
            else
                echo "Greengenes 13-8 database not found! Will be donwloaded"

                # Downloading database

                wget -P project_path/6_databases/ https://data.qiime2.org/2018.6/common/gg-13-8-99-nb-classifier.qza

            fi

            if [ -e ! 6_databases/silva-132-99-nb-classifier.qza ]
            then
                echo "SILVA 132 database found!"
            else
                echo "SILVA 132 database not found! Will be donwloaded"

                # Downloading database

                wget -P project_path/6_databases/ https://data.qiime2.org/2018.6/common/silva-132-99-nb-classifier.qza

            fi
    fi

    



################ 2 Generate executable files ###############

echo Generating executable files

./0_scripts/2_generate_executables_main.sh $project_path

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
    echo submiting condor files.
    #condor_sumbit ./0_scripts/2_import_sequences.condor

    #./2_import_sequences.condor
elif [ $in_patung = n ]
    then 
    echo Executing QIIME locally.
    
    echo Importing sequences
    ./0_scripts/3_import_sequences.sh

    echo Join paired ends

    ./0_scripts/4_vsearch_join-pairs.sh

    echo Quality filter

    } > ./0_scripts/5_quality-filter.sh

    echo Deblur denoise

    ./0_scripts/6_deblur-denoise.sh

    echo Cluster open reference

    ./0_scripts/7_vsearch_cluster_denovo.sh

    echo Alignment

    ./0_scripts/8_alignment_mafft.sh
    
    echo Classifitacion greengenes
    
    ./0_scripts/9_taxonomy_gg_sk.sh

    
fi



if [ $in_patung = y ]
    then
    echo Executing QIIME in patung.
    echo submiting condor files.
    #condor_sumbit ./0_scripts/2_import_sequences.condor

    #./2_import_sequences.condor
elif [ $in_patung = n ]
    then 
    

    
fi