#!/bin/bash


if [ $# -ne 1 ]; then
    echo "Usage: $0 <name_of_test>"
    exit 1
fi

TEST_NAME="$1"
INPUT_DIR="InputFiles"
OUTPUT_DIR="OutputFiles/$TEST_NAME"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

echo "rm -rf bin"
echo "g++ -g -O0 -I . -o bin/interrupts interrupts.cpp"

# Loop through each file in the input directory
for inputfile in "$INPUT_DIR"/*; do
    # Save the input file name without path
    filename=$(basename "$inputfile")
    echo "Processing $filename"

    # Copy input file to trace.txt (original stays unchanged)
    cp "$inputfile" trace.txt

    # Execute the simulator
    ./bin/interrupts trace.txt vector_table.txt device_table.txt

    # Check if execution.txt exists
    if [ ! -f execution.txt ]; then
        echo "Warning: execution.txt not found for $filename"
        rm trace.txt
        continue
    fi

    # Create a copy with test name + input filename + execution.txt
    output_file="${OUTPUT_DIR}/${TEST_NAME}_${filename}_execution.txt"
    cp execution.txt "$output_file"

    # Remove temporary trace.txt
    rm trace.txt

    echo "Saved output to $output_file"
done