k=32
l=30

# Report run time and memory usage
export SHELL=zsh -opipefail
export REPORTTIME=1
export TIMEFMT=time user=%U system=%S elapsed=%E cpu=%P memory=%M job=%J

all: \
	results/200k/k$k/l$l/hsapiens-scaffolds.fac.tsv \
	results/200k.fac.tsv \
	results/optimization.html

.DELETE_ON_ERROR:
.SECONDARY:

# Download the complete data.
data/30CJCAAXX_4.fq.gz:
	mkdir -p $(@D)
	curl -o $@ ftp://ftp.bcgsc.ca/public/sjackman/$(@F)

# Download a subset of the data.
data/200k.fq.gz:
	mkdir -p $(@D)
	curl -o $@ ftp://ftp.bcgsc.ca/public/sjackman/$(@F)

# Take a subset of the data.
data/400k.fq.gz: data/30CJCAAXX_4.fq.gz
	gunzip -c $< | head -n1600000 | gzip >$@

# Unzip the data.
%.fq: %.fq.gz
	gunzip -c $< >$@

# Assemble the data with ABySS.
results/200k/k$k/l$l/hsapiens-scaffolds.fa: data/200k.fq
	mkdir -p $(@D)
	abyss-pe -C $(@D) name=hsapiens k=$k l=$l in=$(realpath $<)

# Calculate the assembly contiguity metrics.
%.fac.tsv: %.fa
	abyss-fac $< >$@

# Concatenate multiple TSV files.
results/200k.fac.tsv: \
		results/200k/k*/l*/hsapiens-scaffolds.fac.tsv \
		results/200k/k$k/l$l/hsapiens-scaffolds.fac.tsv
	mlr --tsvlite cat $^ >$@
	datamash -H max N50 <$@
	head -n1 $@; grep $$(datamash -H max N50 <$@ | tail -n1) $@

# Collect the optimization data.
results/iterations.tsv: output/*.out
	(printf "Iteration\tk\tl\tN50\n"; tail -qn1 $^ | grep '^k=' | sed -E 's/(k|l|N50)=//g' | awk '!x[$$0] {x[$$0] = 1; print}' | cat -n | tr -d ' ') >$@

# Render an RMarkdown report to HTML.
results/%.html: %.rmd
	Rscript -e 'rmarkdown::render("$<", output_file = "$@")'
	sed -i .orig 's/^!\[](results\//![](/' results/$*.md

# Dependencies
results/optimization.html: results/iterations.tsv
