path ?= .
version ?= v1
file ?= allAnnotatedVariants.txt


all: $(version)/$(file)
	

$(version)/$(file):
	mkdir -p $(version)
	curl http://oncokb.org/api/$(version)/utils/$(file) > $(version)/$(file)

