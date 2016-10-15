runAbyss<-function(input, k) {
    name = paste("test_k", k, sep="")
    cmd = paste("abyss-pe",
                " k=", k,
                #" np=8"
                " name=", name,
                " in='", input, "'",
                sep = "")
    print("Running:")
    print(cmd)

    t1 <- try(system(cmd,
                     intern = TRUE,
                     ignore.stderr = TRUE,
                     ignore.stdout = TRUE),
              silent = TRUE)

    if (inherits(t1, "try-error")) {
        print("[FAILED]")
    }
    print("[DONE]")
}


testRunAbyss <- function() {
    #setwd("Hackseq2016/abyss")
    test_input = "../../../data/test-data/reads1.fastq ../../../data/test-data/reads2.fastq"
    runAbyss(test_input, 22)
}

testRunAbyss()


