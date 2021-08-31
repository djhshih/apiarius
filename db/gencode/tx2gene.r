#!/usr/bin/env Rscript

library(argparser)

pr <- arg_parser("Make tx2gene table from GFF");
pr <- add_argument(pr, "input", help="input file name");
pr <- add_argument(pr, "--output", help="output file name");

argv <- parse_args(pr);


library(io)
library(GenomicFeatures)
library(AnnotationDbi)

in.fn <- as.filename(argv$input);
txdb.fn <- tag(tag(in.fn, ext="txdb"), ext="sqlite", replace=TRUE);
print(txdb.fn)

if (file.exists(txdb.fn)) {
	txdb <- loadDb(txdb.fn);
} else {
	txdb <- makeTxDbFromGFF(argv$input);
	saveDb(txdb, txdb.fn);
}

k <- keys(txdb, keytype = "TXNAME");
tx2gene <- select(txdb, k, "GENEID", "TXNAME");

if (is.na(argv$output)) {
	qwrite(tx2gene, tag(tag(in.fn, ext="tx2gene"), ext=c("rds"), replace=TRUE));
} else {
	qwrite(tx2gene, argv$output);
}

