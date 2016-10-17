from opal.core.io import *
import sys
import subprocess as sp
import csv
import os
import shlex
import subprocess

# Run ABySS
def run(param_file, problem):
    "Run abyss with given parameters."
    params = read_params_from_file(param_file)
    k = params['k']

    #datasets = raw_input("dataset(s): ")
    datasets = "200k.fq.gz"

    sp.call(["mkdir", "k%d" % k])

    #sp.call(["ln", "-s", "$PWD/%s" % datasets, "k%d/" % k])
    sp.call("abyss-pe -C k%d name=hsapiens k=%d in=$PWD/200k.fq.gz" % (k, k), shell=True)
    
    #ape = 
    #sp.call(["abyss-pe", "-C", "k%d" % k, "name=hsapiens", "k=%d" % k, "in=$PWD/200k.fq.gz"]) 
    #% datasets]), stdout=sp.PIPE
    #log = sp.Popen(["tee", "abyss.log"], stdin=ape.stdout, stdout=sp.PIPE)
    #ape.stdout.close()
    #alog = log.communicate()[0]
    #ape.wait()
    #alog

    #max_n50 = 0
    with open("k%d/hsapiens-stats.tab" % k) as csvfile:
        csvfile.readline()
        csvreader = csv.reader(csvfile, delimiter="\t")
        for row in csvreader:
            N50 = int(row[5])
            #max_N50 = max(max_N50, N50)
    print "k=%d\tN50=%d" % (k, N50)
    return {'N50': abs(N50)}
    #return {'N50': abs(max_n50)}

if __name__ == '__main__':
    param_file  = sys.argv[1]
    problem     = sys.argv[2]
    output_file = sys.argv[3]

    # Solve, gather measures and write to file.
    #param_file = os.path.abspath(param_file)
    measures = run(param_file, problem)
    write_measures_to_file(output_file, measures)

