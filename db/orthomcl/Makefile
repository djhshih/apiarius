path ?= .
species_src ?= hsapiens
species_dest ?= mmusculus
species_src_sh ?= hsap
species_dest_sh ?= mmus
release ?= release-5

species = $(species_src)-$(species_dest)
biomart_path = ${APIARIUS_DATA}/biomart/release-81


all: orthologs_$(species)_one2one.tsv
	

orthologs.tsv:
	curl http://www.orthomcl.org/common/downloads/$(release)/pairs/orthologs.txt.gz \
		| gunzip -c > orthologs.tsv

orthologs_$(species)_raw.tsv: orthologs.tsv
	grep "$(species_src_sh).*$(species_dest_sh)" orthologs.tsv \
		> orthologs_$(species_src)-$(species_dest)_raw.tsv

orthologs_$(species)_ensp.tsv: orthologs_$(species)_raw.tsv
	$(path)/process.py orthologs_$(species)_raw.tsv orthologs_$(species)_ensp.tsv 
orthologs_$(species)_ens.tsv: orthologs_$(species)_ensp.tsv
	BIOMART_STORE=$(biomart_path) \
		$(path)/ensp2ensg.R orthologs_$(species)_ensp.tsv orthologs_$(species)_ens.tsv

orthologs_$(species).tsv: orthologs_$(species)_ens.tsv
	$(path)/count.py orthologs_$(species)_ens.tsv orthologs_$(species).tsv

orthologs_$(species)_one2one.tsv: orthologs_$(species).tsv
	$(path)/keep-one2one.sh orthologs_$(species).tsv orthologs_$(species)_one2one.tsv

