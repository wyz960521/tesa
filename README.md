# tesa


## Usage

This software provides a tool capable of accurately extracting cis-regulatory motifs with their correct lengths even in thousands of promoters from a whole prokaryotic genome. For a fasta file containing promoters, the program outputs a number of profiles, with increasing order of their pvalue, containing the binding sites of specific motifs.

Certain parts of the code uses open-source data structure library codes, including:
- fib <http://resnet.uoregon.edu/~gurney_j/jmpc/fib.html>, copyright information in fib.c
- Mark A. Weiss's data structure codes <http://www.cs.fiu.edu/~weiss/>


## Installation

enter the folder "tesa" and type "make" then the compiled codes are within the same directory as the source.

## Inputs and outputs

The major program in the provided package is `tesa`, it can parse standard fasta format of files (allowing squences with different length), and example file are provided. 

To see help and look at all available options.

```console
$ ./tesa -h (./tesa)
```

Take a look at `example` (fasta file) first. And try to run tesa under a specific length, now we can handle motif length more than or equal to 5 (controlled in write_block.c line 256).

```console
$ ./tesa -i example -l 14
```

For each input file under a specific length l, our program generates a output file, namely, '.closures'file. In '.closures' file, it provides all the closures, representing motif profiles, in the increasing order of their pvalues.

Then try to run tesa recognizing the correct length in the scope [L,U] by our program automatically

```console
$ ./tesa -i example -L 14 -U 16
```

L and U are low boundary and up boundary of scope of motif length separately. We use this pair of parameters when we do not know the accurate length in advance. We sort the top n closures under each specific length in the increasing order of their pvalues and save the top o clousres in the ".closures" file. Especially, when the input value of L equals to U, it is equivalent to finding motifs in a specific length. '$ ./tesa -i example -L 14 -U 14' is equivalent to '$ ./tesa -i example -l 14'.


## Contact

Any questions, problems, bugs are welcome and should be dumped to
Cankun Wang <cankun.wang@osumc.edu>

