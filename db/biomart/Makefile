path ?= .
species ?= hsapiens
species_dest ?= mmusculus

release = release-*


all: $(release)/ensembl_ids_$(species).tsv $(release)/compara_homologs_$(species)-$(species_dest).tsv
	

$(release)/ensembl_ids_$(species).tsv:
	$(path)/ensembl_id.R $(species)

$(release)/compara_homologs_$(species)-$(species_dest).tsv:
	$(path)/compara_homolog.R $(species) $(species_dest)

