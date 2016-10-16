#!/usr/bin/env python
# Run ABySS for Spearmint

import csv
import os
import shlex
import subprocess

# Run ABySS
def main(job_id, params):
    k = params['k']
    reads = "/Users/sjackman/work/hackseq/2016_project_2/scripts/manual/data/200k.fq"
    output = "/Users/sjackman/work/hackseq/2016_project_2/scripts/manual/results/200k/k%d" % k
    if not os.path.isdir(output):
        os.makedirs(output)
    subprocess.call(shlex.split("abyss-pe -C %s name=hsapiens k=%d in=%s" % (output, k, reads)))
    max_n50 = 0
    with open("%s/hsapiens-stats.tab" % output) as csvfile:
        csvfile.readline()
        csvreader = csv.reader(csvfile, delimiter="\t")
        for row in csvreader:
            n50 = int(row[5])
            max_n50 = max(max_n50, n50)
    print "k=%d\tN50=%d" % (k, n50)
    return -max_n50

if __name__ == "__main__":
    main(None, {"k": 40})
