#Record production-ready code for different tools  
 
##R Optimizers  
- [GA](R_optimizers/GA), which uses genetic algorithms  
	- [CRAN link](https://cran.r-project.org/web/packages/GA/index.html)  

##Python Optimizers  
- ParOpt - uses either grid search or Nelder–Mead to minimize an objective function derived from a command-line tool.


Abyss_wrapper.py uses a pyhon system call to run Abyss. It parses the ouput to report only the value of N50 (contiguity)

One can then use ParOpt to optimize k using a grid search - ParOpt will then tell you the optimum value, k.

```../ParOpt/popt --grid max 'ParOpt/Abyss_wrapper.py {0}' 'fx = (.*)' 25,30,1```

Output:


``` 
0 f(2.500e+01) = 604.0
1 f(2.600e+01) = 994.0
2 f(2.700e+01) = 869.0
3 f(2.800e+01) = 793.0
4 f(2.900e+01) = 669.0
Finished optimization after 5 evaluations.
The optimal function value is -994.000000000000000000000000000000
Optimal variables: 26
```
