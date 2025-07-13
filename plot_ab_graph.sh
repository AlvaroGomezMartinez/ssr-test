#!/bin/zsh

csv_file="$1"
output="ab_graph.png"

# Create temp files
phase_a="phase_a.tmp"
phase_b="phase_b.tmp"

# Extract phase A and B
awk -F',' '$2=="A" { print $1, $3 }' "$csv_file" > "$phase_a"
awk -F',' '$2=="B" { print $1, $3 }' "$csv_file" > "$phase_b"

gnuplot -persist <<EOF
set terminal png size 800,600
set output "$output"
set title "Single-Subject A-B Design"
set xlabel "Session"
set ylabel "Score"
set xrange [0:10]
set xtics 1
set xtics nomirror
unset key

# Vertical divider and labels
set arrow from 3.5, graph 0 to 3.5, graph 1 nohead lc rgb "black" lw 2
set label 1 "A" at 2, graph 0.95 front
set label 2 "B" at 5, graph 0.95 front

plot \
    "$phase_a" using 1:2 with linespoints lt rgb "purple" notitle, \
    "$phase_b" using 1:2 with linespoints lt rgb "purple" notitle
EOF

rm "$phase_a" "$phase_b"
