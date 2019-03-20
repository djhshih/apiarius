path ?= .
release ?= 29
genome ?= grch38

url = ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_$(release)

annotation = gencode.v$(release).annotation.gff3
annotation_pri = gencode.v$(release).primary_assembly.annotation.gff3
# STAR requires GTF format and recommends files marked with PRI (primary)
annotation_pri_gtf = gencode.v$(release).primary_assembly.annotation.gtf

genome_fa = GRCh38.primary_assembly.genome.fa


#all: $(genome)/$(annotation) $(genome)/$(annotation_pri_gtf) $(genome)/$(genome_fa)
all: $(genome)/$(annotation_pri_gtf)
	

$(genome):
	mkdir -p $(genome)

$(genome)/$(annotation): $(genome)
	curl $(url)/$(annotation).gz | gunzip > $(genome)/$(annotation)

$(genome)/$(annotation_pri): $(genome)
	curl $(url)/$(annotation_pri).gz | gunzip > $(genome)/$(annotation_pri)

$(genome)/$(annotation_pri_gtf): $(genome)
	curl $(url)/$(annotation_pri_gtf).gz | gunzip > $(genome)/$(annotation_pri_gtf)

$(genome)/$(genome_fa): $(genome)
	curl $(url)/$(genome_fa).gz | gunzip > $(genome)/$(genome_fa)

