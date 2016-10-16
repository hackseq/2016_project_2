#!/usr/bin/env python

import sys
import numpy as np
import subprocess
import scipy
import os

k = round(float(sys.argv[1]))
k=int(k)
#this is for bsd unix
#fq.gz file needs to be gunzip -k before running this
# parse abyss output so it just reports N50 - For each value of k - supplied by ParOpt
def parse (k):
	os.system('mkdir k%s' %k)
	os.system('ln -s ../200k.fq k%s/' %k)
	os.system('abyss-pe -j 6 -C k%s name=reads k=%s v=-v in="200k.fq" contigs 2>&1 | tee abyss.log' %(k,k))
	test = int(subprocess.check_output("tail -r abyss.log | sed -n 2p | cut -f 6",shell=True).split("\n")[0])
	val = np.array(float(test))
	print("fx = {:.10e}".format(float(val)))
	return "fx = {:.10e}".format(float(val))

parse(int(k))
