#!/bin/bash

for lardir in `find data/ptdb_tug_original/*/LAR/{M,F}* -type dir`; do
  echo "Processing $lardir"
  tclsh extractPitch.tcl $lardir/*.wav
done
