

#!/bin/bash

#-stats.tab   scaffolds n50 (last row, n50 col)

foo() {
    
    echo "Parameter k is $1"

    mkdir k"$1"
    ln -s ../200k.fq
    abyss-pe -C k$1 name=reads k=$1 in="../200k.fq" 2>&1 | tee abyssk$1.log
    #tail -r abyssk$1.log | sed -n 2p | cut -f 6
    #rm -rf k$1
    #grep ${VALUE} k$1/reads_stats.csv | cut -d, -f${INDEX}
    cat k$1/reads_stats.csv| awk -v FS=',' '{print $6}'| head -2 | tail -n 1    
#cat k$1/reads_stats.csv | csvtool -t ',' col "$n50" 
}

foo 30
foo 40
