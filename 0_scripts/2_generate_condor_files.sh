#!/bin/bash

{
printf 'executable 	= %s/3_ejecutables/1_import_seqs.sh\n' "$2" 
echo 'getenv		= True'
printf 'output		= %s/4_outs/1_import_seqs$(Process).out\n' "$2" 
printf 'log  		= %s/5_logs/1_import_seqs$(Process).log\n' "$2" 
printf 'error		= %s/6_errores/1_import_seqs$(Process).error\n' "$2" 

echo 'request_cpus	=5'
echo 'queue'
} > 1_import_seqs_condor.condor
