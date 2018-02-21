#!/bin/bash

g++ pitch_compare.cpp -o pitch_compare

python pitch.py fda_ue.gui

./pitch_compare fda_ue.gui
