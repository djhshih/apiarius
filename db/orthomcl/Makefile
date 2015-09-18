path ?= .
species_src ?= hsapiens
species_dest ?= mmusculus
release ?= release-5

species = $(species_src)-$(species_dest)
biomart_path = ${APIARIUS_DATA}/biomart/release-81


all: orthologs_$(species)_one2one.tsv
	

orthologs.tsv:
	curl http://www.orthomcl.org/common/downloads/$(release)/pairs/orthologs.txt.gz \
		| gunzip -c > orthologs.tsv

orthologs_$(species)_raw.tsv: orthologs.tsv
	$(path)/sel-species.sh orthologs.tsv orthologs_$(species)_raw.tsv $(species_src) $(species_dest)

orthologs_$(species)_ensp.tsv: orthologs_$(species)_raw.tsv
	$(path)/process.py orthologs_$(species)_raw.tsv orthologs_$(species)_ensp.tsv \
		$(species_src) $(species_dest)

orthologs_$(species)_ens.tsv: orthologs_$(species)_ensp.tsv
	BIOMART_STORE=$(biomart_path) \
		$(path)/ensp2ensg.R orthologs_$(species)_ensp.tsv orthologs_$(species)_ens.tsv

orthologs_$(species).tsv: orthologs_$(species)_ens.tsv
	$(path)/count.py orthologs_$(species)_ens.tsv orthologs_$(species).tsv

orthologs_$(species)_one2one.tsv: orthologs_$(species).tsv
	$(path)/keep-one2one.sh orthologs_$(species).tsv orthologs_$(species)_one2one.tsv

