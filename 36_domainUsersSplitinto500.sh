#!/bin/bash

# Set the input file name
input_file="domain_users_mod.txt"

# Set the number of lines per file
lines_per_file=500

# Initialize variables
file_index=1
line_count=0

# Create a new output file
output_file="${input_file}_split_${file_index}.txt"
touch "$output_file"

# Read the input file line by line
while IFS= read -r line; do
    # Append the line to the output file
    echo "$line" >> "$output_file"
    
    # Increment line count
    ((line_count++))

    # If the line count reaches 500, create a new file
    if [ "$line_count" -eq "$lines_per_file" ]; then
        ((file_index++))
        output_file="${input_file}_split_${file_index}.txt"
        touch "$output_file"
        line_count=0
    fi
done < "$input_file"
