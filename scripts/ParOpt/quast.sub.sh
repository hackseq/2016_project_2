# for each round of optimization, run quast: assembly against the reference genome.

for i in k*
do
echo -e '#!/bin/bash 
# 
#SBATCH -N 1 
#SBATCH --mail-type=END
#SBATCH --mail-user=blank
# number of nodes 
#SBATCH -n 6

/home/ubuntu/hackseq/quast-4.3/quast.py --scaffolds -o '$i'_quast -R ../abyss/chr3.fa -t 6 '$i'/reads-scaffolds.fa ' > $i.sub.sh
done
