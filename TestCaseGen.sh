#!/bin/bash
inputs=(
"IO-Bound IO_1 100 1 110"
"IO-Bound IO_2 100 2 300"
"IO-Bound IO_3 100 3 1000"
"CPU-Bound CPU_1 300 6 152"
"CPU-Bound CPU_2 300 7 265"
"CPU-Bound CPU_3 300 9 1000"
"Balanced BAL_1 200 11 145"
"Balanced BAL_2 200 12 523"
"Balanced BAL_3 400 14 636"
)

echo "mkdir InputFiles"

INPUT_DIR="InputFiles"
mkdir -p "$INPUT_DIR"
for line in "${inputs[@]}"; do
    read -r category filename cpuburst devnum devdelay <<< "$line"
    outfile="${INPUT_DIR}/${filename}.txt"
    
    if [ -f "$outfile" ]; then
        rm "$outfile"
    fi

    > "$outfile"
    
    for i in {1..5}; do
        echo "CPU, $cpuburst" >> "$outfile"
        echo "SYSCALL, $devnum" >> "$outfile"
       
        echo "CPU, $cpuburst" >> "$outfile"
        echo "END_IO, $devnum" >> "$outfile"
    done
    
    echo "Generated $outfile"
done