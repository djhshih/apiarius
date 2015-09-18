#!/usr/bin/env Rscript

library(argparser, quietly=TRUE);
library(io, quietly=TRUE);

pr <- arg_parser("Convert a list of identifiers");

pr <- add_argument(pr, "from", help = "current ID type");
pr <- add_argument(pr, "to", help = "target ID type");
pr <- add_argument(pr, "--input", help = "input connection", default="-");
pr <- add_argument(pr, "--output", help = "output connection", default="-");
pr <- add_argument(pr, "--db", help = "path to database");
pr <- add_argument(pr, "--species", help = "species", default="hsapiens");


argv <- parse_args(pr);

if (is.na(argv$db)) {
	db.dir <- Sys.getenv("BIOMART_STORE");
	db <- qread(file.path(db.dir, sprintf("ensembl_ids_%s.rds", argv$species));
} else {
	db <- qread(argv$db);
}

if (argv$input == "-") {
	in.file <- file("stdin");
	open(in.file);
	x <- qread(in.file, type="vector");
} else {
	x <- qread(argv$input);
}

idx <- match(x, db[, argv$from]);
y <- db[idx, argv$to];
y[is.na(y)] <- "";

if (argv$output == "-") {
	write(y, file = stdout());
} else {
	write(y, argv$output);
}

