#!/usr/bin/env python

import sys
import numpy as np
import subprocess
import scipy
import os

k = round(float(sys.argv[1]))
k=int(k)
read1 = sys.argv[2]
read2 = sys.argv[3]

def parse (k):
	os.system('mkdir k%s' %k)
	os.system('ln -s ../reads1.fastq ../reads2.fastq k%s/' %k)
	os.system('abyss-pe -j 6 -C k%s name=reads k=%s v=-v in="%s %s" contigs 2>&1 | tee abyss.log' %(k,k,read1,read2))
	test = int(subprocess.check_output("tac abyss.log | sed -n 3p | cut -f 6",shell=True).split("\n")[0])
	val = np.array(float(test))
	print("fx = {:.10e}".format(float(val)))
	return "fx = {:.10e}".format(float(val))

parse(int(k))
