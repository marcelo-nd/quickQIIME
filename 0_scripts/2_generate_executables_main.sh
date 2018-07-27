#!/bin/bash

# 3 Import sequences

{
echo '#!/bin/bash'

printf 'export TMPDIR=%s/tmp\n' "$1"

echo 'qiime tools import \'
echo "--type 'SampleData[PairedEndSequencesWithQuality]' \\"
printf -- '--input-path %s/1_secuencias/seqs_manifest.txt \\\n' "$1"
echo '--source-format PairedEndFastqManifestPhred33 \'
printf --  '--output-path %s/2_resultados/1_demultiplexed_pairedEnd_seqs.qza' "$1"

} > ./0_scripts/3_import_sequences.sh

# 4 Join pair ends

{
echo '#!/bin/bash'
printf 'export TMPDIR=%s/tmp\n' "$1"

echo 'qiime vsearch join-pairs \'
printf --  '--i-demultiplexed-seqs %s/2_resultados/1_demultiplexed_pairedEnd_seqs.qza \\\n' "$1"
printf --  '--o-joined-sequences %s/2_resultados/2_demultiplexed_joined_seqs_wq.qza \\\n' "$1"
echo '--p-allowmergestagger \'
echo '--verbose'
} > ./0_scripts/4_vsearch_join-pairs.sh

# 5 Quality filter

{
echo '#!/bin/bash'
printf 'export TMPDIR=%s/tmp\n' "$1"

echo 'qiime quality-filter q-score-joined \'
printf -- '--i-demux %s/2_resultados/2_demultiplexed_joined_seqs_wq.qza \\\n' "$1"
echo '--p-min-quality 19 \'
echo '--p-quality-window 5 \'
echo '--p-min-length-fraction 0.5 \'
echo '--p-max-ambiguous 10 \'
printf -- '--output-dir %s/2_resultados/3_q_filter_output \\\n' "$1"
echo '--verbose'
} > ./0_scripts/5_quality-filter.sh

# 6 Deblur denoise

{
echo '#!/bin/bash'
printf 'export TMPDIR=%s/tmp\n' "$1"

echo 'qiime deblur denoise-16S \'
printf -- '--i-demultiplexed-seqs %s/2_resultados/3_q_filter_output/filtered_sequences.qza \\\n' "$1"
echo '--p-trim-length 250 \'
echo '--p-sample-stats \'
echo '--p-jobs-to-start 40 \'
printf -- '--output-dir %s/2_resultados/4_deblur_output \\\n' "$1"
echo '--verbose'
} > ./0_scripts/6_deblur-denoise.sh

# 7 cluster-features-de-novo. Open reference

{
echo '#!/bin/bash'
printf 'export TMPDIR=%s/tmp\n' "$1"

echo 'qiime vsearch cluster-features-de-novo \'
printf -- '--i-sequences %s/2_resultados/4_deblur_output/representative_sequences.qza \\\n' "$1"
printf -- '--i-table %s/2_resultados/4_deblur_output/table.qza \\\n' "$1"
echo '--p-perc-identity 0.97 \'
echo '--p-threads 0 \'
printf -- '--output-dir %s/2_resultados/5_vsearch_output \\\n' "$1"
echo '--verbose'
} > ./0_scripts/7_vsearch_cluster_denovo.sh

# 8 Alignment

{
echo '#!/bin/bash'
printf 'export TMPDIR=%s/tmp\n' "$1"

echo 'qiime alignment mafft \'
printf -- '--i-sequences %s/2_resultados/5_vsearch_output/clustered_sequences.qza \' "$1"
echo '--p-n-threads -1 \'
printf -- '--output-dir %s/2_resultados/6_alignment_output \' "$1"
echo '--verbose'

} > ./0_scripts/8_alignment_mafft.sh

# 9 Clasificación con greengenes. Usando script de qiime2 "qiime feature-classifier classify-sklearn"

{
echo '#!/bin/bash'
printf 'export TMPDIR=%s/tmp\n' "$1"

echo 'qiime feature-classifier classify-sklearn \'
printf -- '--i-reads %s/2_resultados/5_vsearch_output/clustered_sequences.qza \\\n' "$1"
printf -- '--i-classifier %s/7_databases/gg-13-8-99-nb-classifier.qza \\\n' "$1"
echo '--p-n-jobs -1 \'
echo '--p-confidence 0.8 \'
printf -- '--output-dir %s/2_resultados/7_taxonomy_output \\\n' "$1"
echo '--verbose'

} > ./0_scripts/9_taxonomy_gg_sk.sh

# 9 Clasificación con greengenes. PAra patung con la base de datos en el servidor.s

{
echo '#!/bin/bash'
printf 'export TMPDIR=%s/tmp\n' "$1"

echo 'qiime feature-classifier classify-sklearn \'
printf -- '--i-reads %s/2_resultados/5_vsearch_output/clustered_sequences.qza \\\n' "$1"
printf -- '--i-classifier %s/7_databases/gg-13-8-99-nb-classifier.qza \\\n' "$1"
echo '--p-n-jobs -1 \'
echo '--p-confidence 0.8 \'
printf -- '--output-dir %s/2_resultados/7_taxonomy_output \\\n' "$1"
echo '--verbose'

} > ./0_scripts/9_taxonomy_gg_sk_patung.sh

### Silva

