#!/usr/bin/env python

import sys
import numpy as np
import subprocess
import scipy
import os

k = round(float(sys.argv[1]))
s_var = round(float(sys.argv[2]))

k=int(k)
s_var=int(s_var)
# parse abyss output so it just reports N50 - For each value of k - supplied by ParOpt
def parse (k,s_var):
	os.system('mkdir k%s_%s' %(k,s_var))
	os.system('ln -s ../200k.fq.gz k%s_%s/' %(k,s_var))
	os.system('abyss-pe -j 6 -C k%s_%s name=reads k=%s s=%s v=-v in="200k.fq.gz" contigs 2>&1 | tee abyss.log' %(k,s_var,k,s_var))
	test = int(subprocess.check_output("tac abyss.log | sed -n 3p | cut -f 6",shell=True).split("\n")[0])
	val = np.array(float(test))
	print("fx = {:.10e}".format(float(val)))
	return "fx = {:.10e}".format(float(val))

parse(int(k),int(s_var))
