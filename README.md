# ZMP_Reps

Identify various repeats

```
------------------------------------------------------------
Identify Repeats for ZMP, will identify these repeats:

    1. direct repeat:      [ >>>> ------ >>>> ]
    2. mirror repeat:      [ >>>> ------ <<<< ]
    3. MITE candidate:     [ >>tsd ---- tsd--  
                             --tsd ---- tsd<< ]
    4. inverted repeat:    [ >>>> ------ ---- 
                             ---- ------ <<<< ]
    5. everted repeat:     [ >>>> ------ ---- 
                             ---- ------ >>>> ]
------------------------------------------------------------
```

## Installation

1. make sure [seqkit](https://github.com/shenwei356/seqkit) is correctly installed, and available through `$PATH`
2. clone the repository `git clone https://github.com/songtaogui/ZMP_Reps.git`
3. go to the software directory then run `install.sh`:

    ```bash
    cd ZMP_Reps &&\
    ./install.sh
    ```

## Usage

```
------------------------------------------------------------
Identify Repeats for ZMP, will identify these repeats:

    1. direct repeat:      [ >>>> ------ >>>> ]
    2. mirror repeat:      [ >>>> ------ <<<< ]
    3. MITE candidate:     [ >>tsd ---- tsd--  
                             --tsd ---- tsd<< ]
    4. inverted repeat:    [ >>>> ------ ---- 
                             ---- ------ <<<< ]
    5. everted repeat:     [ >>>> ------ ---- 
                             ---- ------ >>>> ]
------------------------------------------------------------
Dependence: grf, repex
------------------------------------------------------------
USAGE:
    bash $(basename $0) [OPTIONS]

OPTIONS: ([R]:required  [O]:optional)
# Common
    -h, --help                          show help and exit.
    -t, --threads       <num>   [O]     Set threads (default: 2)
    -i, --input <str>           [R]     Path to input sequence fasta[.gz]
    -o, --outpre <str>          [O]     Output prefix, default: ZMP_Reps_out
    -m, --modes <str>           [O]     Comma sepereated repeat types to identify, one
                                        or more of: [D,I,E,M,T], or "ALL" for all of them.
                                            D => direct repeat
                                            I => inverted repeat
                                            E => everted repeat
                                            M => mirror repeat
                                            T => MITE candidate
                                        Default: ALL
    --parserealposi             [O]     Parse output to get real positions, see notes below for details

# Filter
    -l, --minlen <int>          [O]     Minimum length (bp) of repeats. Default: 10
    -L, --maxlen  <int>         [O]     Maximum length (bp) of repeats, only works for palindromes
                                        Default: 100
    -g, --maxgap <int>          [O]     Maximum seq length (bp) between repeat pair. Default: 100
    --mintsd <int>              [O]     For MITE only, the minimum length (bp) of tsd. Default: 2
    --maxtsd <int>              [O]     For MITE only, the maximum length (bp) of tsd. Default: 20

# Repeat with mismatch
    -d, --degenerative          [O]     Also identify degenerative repeats.
    -p, --mismatchrate <int>    [O]     Maximum mismatch rate in percentage. Default: 10, 
                                        means no more than 10% mismatchs, only works with "--degerative"

# Misc
    --keep                              keep intermediate files
    --quiet                             keep quiet, only output fatal errors
    --verbose                           be verbose, output detailed logs

NOTE:
    Sometimes, when the input sequence is subset of the real genome sequence, or is concatenated from
    two sequences, we would like to get the real position of the repeats. This script would automatically
    convert the resulted repeats into real positions with "--parserealposi" option, as long as the input
    sequence IDs follow the patterns below:
        
    1. "(\w+)\@(\w+)\@(\d+)\@(\d+)" will be parsed as: ID, real-chr, real-start1, real-end, for subset of 
        real genomes.
    2. "(\w+)\@(\w+)\@(\d+)\@(\d+)\@(\d+)\@(\d+)" will be parsed as ID, real-chr, real-star1-A, real-end-A,
        real-start1-B, real-end-B, for subset and concatenated of two regions. 
        Please note that the parser assumes the two regions were from the same chr.
        !!! ONLY records with left part in region1 and right part in region2 will be print.

------------------------------------------------------------
Author: Songtao Gui
E-mail: songtaogui@sina.com
```
**note:**

Make sure your sequence ID **DO NOT contain `:`**.


## Output file

| #ChrA | StartA | EndA | ChrB          | StartB | EndB | RepeatID      | RepeatLength | StrandA | StrandB | RepeatType    | RepeatIdentity | SeqID         |
| :---- | :----- | :--- | :------------ | :----- | :--- | :------------ | :----------- | :------ | :------ | :------------ | :------------- | :------------ |
| chr1  | 74     | 86   | TESTMITE00030 | 86     | 98   | Reps.D0000001 | 12           | +       | +       | Direct_Repeat | 100.00         | TESTMITE00030 |
| chr1  | 75     | 87   | TESTMITE00030 | 87     | 99   | Reps.D0000002 | 12           | +       | +       | Direct_Repeat | 100.00         | TESTMITE00030 |
| chr1  | 76     | 88   | TESTMITE00030 | 88     | 100  | Reps.D0000003 | 12           | +       | +       | Direct_Repeat | 100.00         | TESTMITE00030 |

The `RepeatID` was in format of `<Outpre.><Repeat-Code><7 digits><.TSD-seq>`, while the repeat codes are:

```bash
D # => direct repeat
I # => inverted repeat
E # => everted repeat
M # => mirror repeat
T # => MITE candidate
```

The `<.TSD-seq>` section will only be appeared in MITE candidates.
