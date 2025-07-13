#!/bin/zsh

csv_file="$1"
output="abab_graph.png"

phase_a1="phase_a1.tmp"
phase_b1="phase_b1.tmp"
phase_a2="phase_a2.tmp"
phase_b2="phase_b2.tmp"

# Dynamically split into phases
awk -F',' '
NR == 1 { next } # Skip header line
BEGIN { prev=""; block=0 }
{
  if ($2 != prev) {
    block++
    prev = $2
  }
  if (block == 1 && $2 == "A") print $1, $3 > "'"$phase_a1"'"
  else if (block == 2 && $2 == "B") print $1, $3 > "'"$phase_b1"'"
  else if (block == 3 && $2 == "A") print $1, $3 > "'"$phase_a2"'"
  else if (block == 4 && $2 == "B") print $1, $3 > "'"$phase_b2"'"
}
' "$csv_file"

gnuplot -persist <<EOF
set terminal png size 800,600
set output "$output"
set title "Single-Subject A-B-A-B Design"
set xlabel "Session"
set ylabel "Score"
set xrange [0:10]
set xtics 1
set xtics nomirror
unset key

# Vertical dividers and labels
set arrow from 3.5, graph 0 to 3.5, graph 1 nohead lc rgb "black" lw 2
set arrow from 6.5, graph 0 to 6.5, graph 1 nohead lc rgb "black" lw 2
set arrow from 8.5, graph 0 to 8.5, graph 1 nohead lc rgb "black" lw 2

set label 1 "A" at 2, graph 0.95 front
set label 2 "B" at 5, graph 0.95 front
set label 3 "A" at 7.5, graph 0.95 front
set label 4 "B" at 9.5, graph 0.95 front

plot \
    "$phase_a1" using 1:2 with linespoints lt rgb "purple" notitle, \
    "$phase_b1" using 1:2 with linespoints lt rgb "purple" notitle, \
    "$phase_a2" using 1:2 with linespoints lt rgb "purple" notitle, \
    "$phase_b2" using 1:2 with linespoints lt rgb "purple" notitle
EOF

rm "$phase_a1" "$phase_b1" "$phase_a2" "$phase_b2"
