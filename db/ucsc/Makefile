genome ?= hg38
table ?= knownGene

url = http://hgdownload.soe.ucsc.edu/goldenPath/$(genome)/database

all: $(genome)/$(table).txt.gz
	

$(genome)/$(table).txt.gz:
	curl $(url)/$(table).txt.gz > $(genome)/$(table).txt.gz

