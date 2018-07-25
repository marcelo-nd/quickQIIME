#!/bin/bash
source /srv/home/anavarro/miniconda3/bin/activate qiime2
qiime tools import \
--type 'SampleData[PairedEndSequencesWithQuality]' \
--input-path $1 \
--source-format PairedEndFastqManifestPhred33 \
--output-path $2 \
