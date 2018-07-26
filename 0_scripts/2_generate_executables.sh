#!/bin/bash

{
echo '#!/bin/bash'

printf 'export TMPDIR=%s/tmp\n' "$1"

echo 'qiime tools import \'
echo "--type 'SampleData[PairedEndSequencesWithQuality]' \\"
printf -- '--input-path %s/1_secuencias/seqs_manifest.txt \\\n' "$1"
echo '--source-format PairedEndFastqManifestPhred33 \'
printf --  '--output-path %s/2_resultados/1_demultiplexed_pairedEnd_seqs.qza' "$1"

} > ./0_scripts/3_import_sequences.sh
