#!/bin/sh
# the next line restarts using wish \
exec wish "$0" "$@"

package require snack

snack::sound s
foreach file $argv {
 s read $file

 set fd [open [file rootname $file].f0 w]
 puts $fd [join [s pitch -method esps -windowlength 0.032 -framelength 0.01] \n]
 close $fd
}

exit
