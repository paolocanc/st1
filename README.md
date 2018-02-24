# Speech Technologies. #
#### Master’s degree in Telecommunications Engineering (MET). Universitat Politècnica de Catalunya ####

Assignment: Pitch and voicing estimation  
Professor: José Adrián Rodríguez Fonollosa

The objective of this assignment is the analysis of basic properties of the speech signal: voicing and pitch, and to develop accurate estimation algorithms of these parameters.}

## Assignment ##

* Select at least two algorithms for pitch estimation and voicing detection.
* Implement the selected methods in any language (C++, python or MATLAB) and compare their performance on the FDA-UE database. You can use the provided [pitch.py](pitch.py) and [test.sh](test.sh) scripts as starting point or reference. The [pitch.py](pitch.py) script uses a basic algorithm based on the autocorrelation to compute the pitch, while the [test.sh](test.sh) script shows how to evaluate the performance of a method.
* Try to improve the results with the use of standard pre- and post-processing methods, new algorithms, a combination of systems, parameter tuning or machine learning algorithms. Optionally, you can use the large PTDB-TUB database for tuning and training and keep the FDA-UE database just for the final evaluation.
* Use the provided C++ [pitch_compare](pitch_compare.cpp) program to report the results as v/uv errors, uv/v errors, gross pitch errors (>20%) and MSE (Mean Squared Error) of the relative fine pitch errors. (See the [test.sh](test.sh) script)
* Report the results of the assignment using a 4-pages paper format. You can use, for instance, the templates in http://www.icassp2016.com/papers/PaperKit.html#Templates. In the report you have to briefly describe the selected algorithms and initial source code including the corresponding references. Then you have to mention your experiments or original contributions and the obtained results.
* Upload the complete source code to a git repository (as github) and provide a link to it in the report.

## Databases ##
We have prepared two databases for the development and testing of the pitch estimation and voicing detection algorithms.

* **FDA-UE** database: (sampling rate = 20KHz, frame shift = 15 ms)  
The Fundamental Frequency Determination Algorithm Evaluation Database (FDA-UE) was prepared by Paul Bagshaw, Centre for Speech Technology Research, University of Edinburgh. The original database includes audio files (20KHz, 16bit) and a file with the f0 contour obtained from a second file that contains the output of a laryngograph. This apparatus measures impedance between the sensors that are connected to both sides of the larynx, whereby the contour obtained can be used as a reference. We have made a change in format, so that our audio files are in .wav format (instead of raw format), and f0 contours of reference (.f0ref) are interpolated every **15 ms**

* **PTDB-TUB** database: (sampling rate = 48KHz, frame shift = 10 ms)  
The Pitch Tracking Database from Graz University of Technology (PTDB-TUG) is a speech database for pitch tracking that provides microphone and laryngograph signals of 20 English native speakers as well as the extracted pitch trajectories as a reference. The subjects had to read 2342 phonetically rich sentences from the existing TIMIT corpus. This text material is available spoken by both, female and male speakers. In total, this database consists of 4720 recorded sentences. All recordings were carried out on-site at the recording studio of the Institute of Broadband Communications at Graz University of Technology. In the version of this database provided for this work, we keep the audio files in the original .wav format with a sampling rate of 48KHz, but we have reformatted the f0 contours of reference (.f0ref) as in the previous database. However, in this database the f0 of reference are computed every **10 ms** with a window of 32ms and no padding.


## Pitch estimation and voicing detection program ##

For each .wav file, your program should output a text file with extension .f0 and a line every 15 milliseconds (FDA-UE) or 10 milliseconds (PTDB-TUG), indicating the fundamental frequency in Hz. If the segment is unvoiced, you must write a line with a ’0’.

You can use the provided [pitch.py](pitch.py) python script as a starting point or reference. The program [pitch.py](pitch.py) need an argument: FILELIST (a file with the list of files to process without the .wav extension and it has four options:

```
Usage: python3 pitch.py [OPTION]... FILELIST

Options:
  -h, --help            show this help message and exit
  -w WINDOWLENGTH, --windowlength=WINDOWLENGTH
                        windows length (ms)
  -f FRAMESHIFT, --frameshift=FRAMESHIFT
                        frame shift (ms)
  -p PADDING, --padding=PADDING
                        zero padding (ms)
  -d DATADIR, --datadir=DATADIR
                        data folder
```
### Examples ###
To process the fda_ue database:
```
python3 pitch.py fda_ue.gui
```
To process the ptdb_tug database select no padding and a frame shift of 10ms:
```
python3 pitch.py -p 0 -f 10 ptdb_tug.gui
```

## Evaluation ##
Once you have all the files with the detected pitch, (extension .f0) in the same directory as the reference files (extension .f0ref), you can execute the [pitch_compare](pitch_compare.cpp) program to evaluate your method.

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
  Pitch errors greater than 20%
* MSE of fine errors:  
  In voiced frames, detected as voiced with an error less than 20%,  
  the average of that error. (Mean Squared Error)

It also provides a summary with the average over all files.


## Source code license ##
* The source code of this project is licensed under the terms of the MIT license

## Detailed information about the databases ##
* More details about the FDA-UE database can be found in http://www.cstr.ed.ac.uk/research/projects/fda/
* More details about the PTDB-TUB database can be found in G. Pirker, M. Wohlmayr, S. Petrik, and F. Pernkopf. ["A Pitch Tracking Corpus with Evaluation on Multipitch Tracking Scenario"](https://www.spsc.tugraz.at/system/files/InterSpeech2011Master_0.pdf), Interspeech, pp. 1509-1512, 2011.  
The PTDB-TUG Database is made available under the Open Database License: http://opendatacommons.org/licenses/odbl/1.0/  
Any rights in individual contents of the database are licensed under the Database Contents License: http://opendatacommons.org/licenses/dbcl/1.0/ Please cite the above given reference when using the database. 
