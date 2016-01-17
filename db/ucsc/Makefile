path ?= .
genome ?= hg38
table ?= knownGene

url = http://hgdownload.soe.ucsc.edu/goldenPath/$(genome)/database

all: $(genome)/$(table).txt $(genome)/$(table).db
	

$(genome)/$(table).txt:
	mkdir -p $(genome)
	curl $(url)/$(table).txt.gz | gunzip > $(genome)/$(table).txt

$(genome)/$(table).db: $(genome)/$(table).txt
	curl $(url)/$(table).sql | $(path)/sql2sqlite.sh > $(genome)/$(table).sqlite
	$(path)/sqlite.sh $(genome)/$(table)

