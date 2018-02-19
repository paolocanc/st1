# Speech Technologies. Master MET. UPC #

## Pitch Estimation Assigment ##

### Autocorrelation-based pitch estimation baseline ###

```
Usage: pitch.py [OPTION]... FILELIST
Options:
  -h, --help            show this help message and exit
  -w WINDOWLENGTH, --windowlength=WINDOWLENGTH
                        windows length (ms)
  -f FRAMELENGTH, --framelength=FRAMELENGTH
                        frame shift (ms)
  -d DATADIR, --datadir=DATADIR
                        root data folder
```

## Evaluation ###

Once you have all the files with the detected pitch, (extension .f0), which must be in the same directory as the reference files (extension .f0ref), you can execute the pitch\_compare program to evaluate your method.

After compiling the program:
```
$ make
```
you can call it with the same FILELIST as argument
```
$ ./pitch_compare FILELIST
```
This program calculates, for each file:
* Voiced frames -> unvoiced (1 - recall voiced)  
  Number of unvoiced frames that have been erroneously classified as voiced.
* Unvoiced frames -> voiced: (1 - recall unvoiced)  
  Number of voiced frames that have been erroneously classified as unvoiced.
* Gross voiced errors:  
  In voiced frames, detected as voiced,  
  Pitch errors greater than 20\%
* MSE of fine errors:  
  In voiced frames, detected as voiced with an error less than 20\%,  
  the average of that error. (Mean Squared Error)

It also provides a summary with the average over all files.

