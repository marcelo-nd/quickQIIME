#!/bin/bash
export TMPDIR=/home/chelo/agave/tmp
qiime tools import \
--type 'SampleData[PairedEndSequencesWithQuality]' \
--input-path /home/chelo/agave/1_secuencias/seqs_manifest.txt \
--source-format PairedEndFastqManifestPhred33 \
--output-path /home/chelo/agave/2_resultados/1_demultiplexed_pairedEnd_seqs.qza