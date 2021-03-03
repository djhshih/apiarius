path ?= .
release ?= 37
genome ?= grch38

url = ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_$(release)

annotation = gencode.v$(release).annotation.gff3
annotation_pri = gencode.v$(release).primary_assembly.annotation.gff3
# STAR requires GTF format and recommends files marked with PRI (primary)
annotation_pri_gtf = gencode.v$(release).primary_assembly.annotation.gtf

genome_fa = $(subst grch,GRCh,$(genome)).primary_assembly.genome.fa

transcriptome_fa = gencode.v$(release).transcripts.fa


all: $(genome)/$(annotation) $(genome)/$(annotation_pri_gtf) $(genome)/$(genome_fa) $(genome)/$(transcriptome_fa)
	

$(genome):
	mkdir -p $(genome)

$(genome)/$(annotation): $(genome)
	curl $(url)/$(annotation).gz | gunzip > $(genome)/$(annotation)

$(genome)/$(annotation_pri): $(genome)
	curl $(url)/$(annotation_pri).gz | gunzip > $(genome)/$(annotation_pri)

$(genome)/$(annotation_pri_gtf): $(genome)
	curl $(url)/$(annotation_pri_gtf).gz | gunzip > $(genome)/$(annotation_pri_gtf)

$(genome)/$(genome_fa): $(genome)
	curl $(url)/$(genome_fa).gz > $(genome)/$(genome_fa).gz
	gunzip -k $(genome)/$(genome_fa)

$(genome)/$(transcriptome_fa): $(genome)
	curl $(url)/$(transcriptome_fa).gz > $(genome)/$(transcriptome_fa).gz

