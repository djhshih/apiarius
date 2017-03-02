path ?= .
project ?= genie
version ?= v1

target_opt = --downloadLocation $(project)/$(version)
download = $(path)/get-synapse.sh $(target_opt)

all: $(project)/$(version)
	

# syn7851250	data_mutations_extended.txt
# syn7851246	data_clinical.txt
# syn7851245	data_CNA.txt
# syn7851252	genie_combined.bed
# syn7851249	data_fusions.txt
# syn7851253	genie_data_cna_hg19.seg
# syn7851703	data_guide.pdf
genie/$(version):
	mkdir -p $(project)/$(version)
	$(download) syn7851250
	$(download) syn7851246
	$(download) syn7851245
	$(download) syn7851252
	$(download) syn7851249
	$(download) syn7851253
	$(download) syn7851703

