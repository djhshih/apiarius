#!/usr/bin/env Rscript

# Prepare cytoBand.txt and re-format as RDS file


# Compile start and end positions of each chromosome arm
get_chrom_arm_pos <- function(cytobands, include.whole=FALSE) {

	# remove cytobands with missing values
	cytobands <- cytobands[cytobands$cytoband != "", ];

	chr.parts.chromosome <- NULL;
	chr.parts.arm <- NULL;
	chr.parts.start <- NULL;
	chr.parts.end <- NULL;
	for (cytobands.chr in unique(cytobands$chromosome)) {
		cytobands.sub <- cytobands[cytobands$chromosome ==	cytobands.chr,];
		for (arm in c("p", "q")) {
			i <- grep(arm, cytobands.sub$cytoband);
			arm.start <- min(cytobands.sub$start[i])
			arm.end <- max(cytobands.sub$end[i]);
			chr.parts.chromosome <- c(chr.parts.chromosome, cytobands.chr);
			chr.parts.arm <- c(chr.parts.arm, arm);
			chr.parts.start <- c(chr.parts.start, arm.start);
			chr.parts.end <- c(chr.parts.end, arm.end);
		}
		if (include.whole) {
			chr.parts.chromosome <- c(chr.parts.chromosome, cytobands.chr);
			chr.parts.arm <- c(chr.parts.arm, "");
			chr.parts.start <- c(chr.parts.start, min(cytobands.sub$start));
			chr.parts.end <- c(chr.parts.end, max(cytobands.sub$end));
		}
	}
	chr.parts <- data.frame(chromosome=chr.parts.chromosome, arm=chr.parts.arm, start=chr.parts.start, end=chr.parts.end);
	chr.parts <- chr.parts[order(chr.parts$chromosome, chr.parts$arm),];
	return (chr.parts);
};

get_chromosome_levels <- function(chroms) {
	chroms.uniq <- unique(chroms);
	suppressWarnings( x <- as.integer(chroms.uniq) );
	numbered <- sort(x[!is.na(x)]);

	c(numbered, sort(chroms.uniq[is.na(x)]));
}


make_cytoband <- function(cytoband.fname) {
	cytobands <- read.table(cytoband.fname, header=FALSE, sep="\t", as.is=TRUE);
	names(cytobands) <- colnames(cytobands) <- c("chromosome", "start", "end", "cytoband", "assembly");
	cytobands$chromosome <- gsub("chr", "", cytobands$chromosome);

	# ignore contigs (assume they contain "_"
	cytobands <- cytobands[
		grep("_", cytobands$chromosome, fixed=TRUE, invert=TRUE), ];

	# convert chromosome field to factor
	cytobands$chromosome <- factor(cytobands$chromosome,
		 levels=get_chromosome_levels(cytobands$chromosome));

	# sort by chromosome and position
	cytobands <- cytobands[order(cytobands$chromosome, cytobands$start, cytobands$end),];

	# Generate chromosome arms data.frame
	chrom.arms = get_chrom_arm_pos(cytobands, include.whole=TRUE);

	# Generate chromosome lengths vector
	chrom.lens <- unlist( lapply(levels(cytobands$chromosome), function(x) {
		max(cytobands$end[cytobands$chromosome == x])
	}) );
	names(chrom.lens) <- levels(cytobands$chromosome);

	return( list(
		cytobands = cytobands,
		chrom.arms = chrom.arms,
		chrom.lens = chrom.lens
	) );
}

y <- make_cytoband("cytoBand.txt");

saveRDS(y, "cytoBand.rds");

