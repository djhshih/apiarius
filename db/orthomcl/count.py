#!/usr/bin/env python3
# Process orthology table, determine orthology type


import sys


in_fname = sys.argv[1]
out_fname = sys.argv[2]
delim = '\t'


def get_genes(line):
    tokens = line.rstrip().split('\t')
    gene1 = tokens[0]
    gene2 = tokens[1]
    return (gene1, gene2)


def count_gene(gene, counts):
    if gene in counts:
        counts[gene] += 1
    else:
        counts[gene] = 1


# maps for counting occurrences of genes
counts1 = {}
counts2 = {}

with open(in_fname) as inf:

    species  = inf.readline().rstrip().split('\t')

    for line in inf:

        gene1, gene2 = get_genes(line)
        count_gene(gene1, counts1)
        count_gene(gene2, counts2)


with open(out_fname, 'w') as outf:

    outf.write("{}\n".format(delim.join(
        [species[0], species[1], 'orthology_type']
    )))

    with open(in_fname) as inf:

        # discard header line
        inf.readline()

        for line in inf:
            
            gene1, gene2 = get_genes(line)
            if counts1[gene1] == 1:
                if counts2[gene2] == 1:
                    orthology_type = 'ortholog_one2one'
                else:
                    orthology_type = 'ortholog_one2many'
            else:
                if counts2[gene2] == 1:
                    orthology_type = 'ortholog_many2one'
                else:
                    orthology_type = 'orthology_many2many'
            
            outf.write("{}\n".format(delim.join(
                [gene1, gene2, orthology_type]
            )))

