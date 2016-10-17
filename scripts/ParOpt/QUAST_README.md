For each optimization, run QUAST with the reference genome to collect assembly quality statistics

```
/home/ubuntu/hackseq/quast-4.3/quast.py --scaffolds -o '$i'_quast -R ../abyss/chr3.fa -t 6 '$i'/reads-scaffolds.fa ' > $i.sub.sh
```
Output is as follows:
quast_output.tar
-k_s_l_n/
Where the folder name represents different parameter values:

report.txt in each folder gives useful information, N50, number of missasemblies, total number of bases covered in reference, largest contig assembled, GC content etc.

These values plotted against N50 would indicate how well the optimization has worked.


