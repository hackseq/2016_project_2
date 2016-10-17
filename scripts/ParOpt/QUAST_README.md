For each optimization, run QUAST with the reference genome to collect assembly quality statistics

```
/home/ubuntu/hackseq/quast-4.3/quast.py --scaffolds -o '$i'_quast -R ../abyss/chr3.fa -t 6 '$i'/reads-scaffolds.fa ' > $i.sub.sh
```

