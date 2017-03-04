path ?= .
genome ?= grch38
genome_n = $(shell echo $(genome) | sed s/grc/GRC/)
url = ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar

# NB  ClinVar is updated monthly. Some resources are updaed weekly or daily.


all: gene_condition_source_id.tsv variant_summary.tsv gene_specific_summary.tsv $(genome)/clinvar.vcf.gz

$(genome):
	mkdir -p $(genome)

$(genome)/clinvar.vcf.gz: $(genome)
	curl $(url)/vcf_$(genome_n)/clinvar.vcf.gz > $@

gene_condition_source_id.tsv:
	curl $(url)/gene_condition_source_id | sed -e '1s/^.//' > $@

variant_summary.tsv:
	curl $(url)/tab_delimited/variant_summary.txt.gz | gunzip | sed -e '1s/^.//' > $@

gene_specific_summary.tsv:
	curl $(url)/tab_delimited/gene_specific_summary.txt | sed -e '2s/^.//' > $@


# additional tab delimited files:

#variation_allele.txt.gz
#allele_gene.txt.gz
#hgvs4variation.txt.gz

