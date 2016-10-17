#!/usr/bin/env python
# Run ABySS for Spearmint

import csv
import os
import shlex
import subprocess

# Run ABySS
def main(job_id, params):
    k = params['k']
    l = params['l']
    subprocess.call(shlex.split("make k=%d l=%d" % (k, l)))
    max_n50 = 0
    with open("results/200k/k%d/l%d/hsapiens-scaffolds.fac.tsv" % (k, l)) as csvfile:
        csvfile.readline()
        csvreader = csv.reader(csvfile, delimiter="\t")
        for row in csvreader:
            n50 = int(row[5])
            max_n50 = max(max_n50, n50)
    print "k=%d\tl=%d\tN50=%d" % (k, l, n50)
    return -max_n50

if __name__ == "__main__":
    main(None, {"k": 40, "l": 40})
