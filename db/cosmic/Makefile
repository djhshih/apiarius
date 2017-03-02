path ?= .
genome ?= grch38
version ?= v80
table ?= CosmicMutantExport
ext ?= tsv

all: signatures_probabilities.txt $(genome)/$(version)/$(table).$(ext)
	

signatures_probabilities.txt:
	curl -O http://cancer.sanger.ac.uk/cancergenome/assets/signatures_probabilities.txt

$(genome)/$(version)/$(table).tsv:
	$(path)/get-cosmic.sh $(genome) $(version) $(table) . tsv 1

$(genome)/$(version)/$(table).csv:
	$(path)/get-cosmic.sh $(genome) $(version) $(table) . csv 0

$(genome)/$(version)/$(table).vcf:
	$(path)/get-cosmic.sh $(genome) $(version) $(table) VCF vcf 1

# All_COSMIC_Genes.fasta.gz
# CosmicBreakpointsExport.tsv.gz
# CosmicCompleteCNA.tsv.gz
# CosmicCompleteDifferentialMethylation.tsv.gz
# CosmicCompleteGeneExpression.tsv.gz
# CosmicCompleteTargetedScreensMutantExport.tsv.gz
# CosmicFusionExport.tsv.gz
# CosmicGenomeScreensMutantExport.tsv.gz
# CosmicHGNC.tsv.gz
# CosmicMutantExport.tsv.gz
# CosmicMutantExportCensus.tsv.gz
# CosmicNCV.tsv.gz
# CosmicResistanceMutations.tsv.gz
# CosmicSample.tsv.gz
# CosmicStructExport.tsv.gz
# CosmicTranscripts.tsv.gz
# README-cosmic.txt
# VCF/CodingCodingMuts.vcf.gz
# VCF/CosmicNonCodingVariants.vcf.gz
# ascat_acf_ploidy.tsv
# cancer_gene_census.csv 
# classification.csv

