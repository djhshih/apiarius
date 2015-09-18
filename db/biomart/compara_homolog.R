#!/usr/bin/env Rscript

library(io);
library(argparser);

options(filenamer.timestamp=0, filenamer.path.timestamp=0);

pr <- arg_parser("Get compara homologs");
pr <- add_argument(pr, "species", "source species (e.g. hsapiens)")
pr <- add_argument(pr, "species_dest", "destination species (e.g. mmusculus)")

argv <- parse_args(pr);

species <- argv$species;
species_dest <- argv$species_dest

library(biomaRt);

mart <- useMart(biomart = "ensembl",
	dataset = sprintf("%s_gene_ensembl", species));
release <- sub("[^0-9]*([0-9]+)", "\\1", listEnsembl()$version[1]);

results <- getBM(attributes = c(
	"ensembl_gene_id",
	paste(species_dest, c("homolog_ensembl_gene", "homolog_orthology_type"), sep="_")
), mart = mart);

results <- results[results[, 2] != "", ];

output.fname <- filename("compara_homologs",
	tag = paste(species, species_dest, sep="-"),
	path = sprintf("release-%s", release))

qwrite(results, tag(output.fname, ext="rds"));
qwrite(results, tag(output.fname, ext="tsv"));

