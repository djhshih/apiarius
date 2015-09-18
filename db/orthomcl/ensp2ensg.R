#!/usr/bin/env Rscript

library(argparser);
library(io);

pr <- arg_parser("Convert ensembl peptide ID to ensembl gene ID for each table column");

pr <- add_argument(pr, "input", help = "input file");
pr <- add_argument(pr, "output", help = "output file");
pr <- add_argument(pr, "--dbdir", help = "directory of database");
pr <- add_argument(pr, "--keepna", help = "do not missing entries", flag=TRUE);

argv <- parse_args(pr);

if (is.na(argv$dbdir)) {
	db.dir <- Sys.getenv("BIOMART_STORE");
} else {
	db.dir <- argv$dbdir;
}


map_id <- function(x, db, from, to) {
	idx <- match(x, db[, from]);
	db[idx, to];
}

x <- qread(argv$input, as.is=TRUE);

for (species in colnames(x)) {
	message(species);
	db <- qread(file.path(db.dir, sprintf("ensembl_ids_%s.rds", species)));
	y <- map_id(x[, species], db, "ensembl_peptide_id", "ensembl_gene_id")
	x[, species] <- y;
}

if (!argv$keepna) {
	x <- x[complete.cases(x), ];
}

qwrite(x, argv$output);

