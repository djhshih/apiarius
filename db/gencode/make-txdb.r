#!/usr/bin/env Rscript

library(argparser)

pr <- arg_parser("Make TxDb from GFF");
pr <- add_argument(pr, "input", help="input file name");
pr <- add_argument(pr, "output", help="output file name");

argv <- parse_args(pr);


library(GenomicFeatures)
library(AnnotationDbi)

txdb <- makeTxDbFromGFF(argv$input);
saveDb(txdb, argv$output);

