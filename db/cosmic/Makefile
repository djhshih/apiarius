path ?= .
genome ?= grch38
version ?= v79
table ?= CosmicMutantExport

all: signatures_probabilities.txt $(genome)/$(table).tsv

signatures_probabilities.txt:
	curl -O http://cancer.sanger.ac.uk/cancergenome/assets/signatures_probabilities.txt

$(genome)/$(table).tsv:
	$(path)/get-cosmic.sh $(genome) $(version) $(table)

