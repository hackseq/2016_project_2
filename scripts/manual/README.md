# Manual Optimization

Run ABySS multiple times, manually, for multiple values of *k*, and determine which assembly has the largest N50.

# Usage

```sh
make k=24
make k=28
make k=32
make
datamash -H max N50 <200k.fac.tsv
head -n1 200k.fac.tsv; grep $(datamash -H max N50 <200k.fac.tsv | tail -n1) 200k.fac.tsv
```
