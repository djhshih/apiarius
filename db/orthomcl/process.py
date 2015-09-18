#!/usr/bin/env python3
# Process orthology table, determine orthology type


import sys

species = ['hsapiens', 'mmusculus']
in_fname = sys.argv[1]
out_fname = sys.argv[2]
delim = '\t'


def get_genes(line):
    tokens = line.rstrip().split('\t')
    gene1 = tokens[0][(tokens[0].index('|')+1):]
    gene2 = tokens[1][(tokens[1].index('|')+1):]
    return (gene1, gene2)


with open(out_fname, 'w') as outf:

    outf.write("{}\n".format(delim.join(species)))

    with open(in_fname) as inf:

        for line in inf:

            gene1, gene2 = get_genes(line)

            outf.write("{}\n".format(delim.join(
                [gene1, gene2]
            )))

