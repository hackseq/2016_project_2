# Design a tool to optimize the parameters of any command line tool

Project Lead: [Shaun Jackman](http://sjackman.ca) / [@sjackman](https://twitter.com/sjackman) / Graduate Student / BC Cancer Agency Genome Sciences Centre

Given a command line tool with a number of parameters and a target metric to be optimized, I want a tool that will run the program and find the values for those parameters that maximizes some target metric. My particular use case is genome sequence assembly, which often has a variety of parameters related to expected coverage of the reads and heuristics to remove read errors and collapse heterozygous variation. When I tackle that optimization, the process is manual and tedious: submitting jobs to a scheduler, rerunning failed jobs, inspecting outputs, tweaking parameters, and repeating. I want to design and implement a tool to automate that process and generate a report of the result.
