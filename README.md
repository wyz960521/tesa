# TESA


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

## Running TESA using an input file with base coverage signal

You can run TESA with another option using base coverage signal according to the following instructions:
 
1. Make sure both Bedtools and BigWigMerge are ready.
2. A peak file with BED format(for instance, [PREFIX].bed), two bigwig files named [PREFIX]_Forward.bw and [PREFIX]_Reverse.bw respectively and a reference file with FASTA format with its reference with FAI format are required. For instance, there is a toy run with test.bed, test_Forward.bw, test_Reverse.bw, sequence.fa and sequence.fa.fai as input. Additionally, you can generate reference using samtools.
3. Run preprocessing script and generate output file *.tesa.
```console
$ chmod +x preprocess.sh
$ ./preprocess.sh [PEAK_PREFIX] [REFERENCE_FILE] [REFERENCE_INDEX_FILE] [OUTPUT_PREFIX]
```
For instance:
```console
$ ./preprocess.sh TEST sequence.fa sequence.fa.fai TEST_out
```   
4. Run TESA beyond new input with base coverage signal.
```console
$ ./tesa [OUTPUT_PREFIX].tesa
```
## Parameter

| Option  | Parameter | Description | Default |
| Commonly used parameters |
| ------------- | ------------- | ------------- | ------------- |
| -l  | length  | motif length [5,l] | Specify length of target motif length. In general, this value should be greater than 5. | 14 |
| -L  | motif length [L,U] | Specify minimum target motif length. This parameter only takes effect when l is not specified. | Not effective |
| -U  | motif length [L,U] | Specify maximum target motif length. Must have a value greater than L. This parameter only takes effect when l is not specified. | Not effective |
| -o  | number of closures  | Number of closures to report (used under a specific input length). Only effective when the value is greater than the total number of closures found by this tool. | Report 10 closures in default. |
| -B  |  whether to search reverse complement | TRUE or FALSE. If it is set TRUE ture， the program will search both the forward complement and reverse complement. | TURE in default which means input sequence should be bidirectional. |


Commonly used parameters:

-l : motif length [5, ]
     default: 14
     
-L : minimum motif length
     default: 14
     
-U : maximum motif length
     default: 14
     
-o : number of closures to report (used under a specific input length)
     default: 10
     
-B : search reverse complement
     default: TRUE
     
Advanced parameters:

-n : top n closures under each length are used when L < U 
     default: 1
     
-w : the weight of the two motif ends 
     default: 2
     
-k : the minimum size of the initial motif seeds,
     default: 3
     
-c : consistency level of the motif seeds (0.5-1.0]
     default: 1
     
-s : the nunber of simulation times [5, ]
     default: 5
     
-u : the threshold of two closures' similarity socre (0,1]
     default: 0.95
     
-a : the upper limit of conservation level (N,10]
     default: 9
     
-N : the lower limit of conservation level (0,a)
     default: 6
     
-P : the flag of palindromic of TFBS
     default: FALSE
     
-M : the flag of mirror of TFBS
     default: FALSE
     
-G : the flag of global TF prediction
     default: FALSE
     
-C : the flag of local TF prediction
     default: FALSE
     
-E : the flag of expansion of closures base on the threshold 0.3-0.8
     default: FALSE
     
-A : the flag of approximation of pvalue calculation
     default: FALSE
     
-F : the flag of fast version of wtsa which just enhance two ends of motif
     default: FALSE
     
-W : the flag of considering sequences weight
     default: FALSE
     
-R : the range when we use [L,U]
     default: 1
     
-e : the times of seed alignments enlargement [1,3]
     default: 3
     
-b : the conserve level when search in background genome
     default: 0.95
     
## Contact

Any questions, problems, bugs are welcome and should be dumped to
Cankun Wang <cankun.wang@osumc.edu>

