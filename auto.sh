#!/bin/bash

### Base directory where the folders are located ###
base_dir=


######################################################
######################################################

# Ensure sorting handles UTF-8 correctly
export LC_ALL=C.UTF-8

# Get the directory of the current script
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Loop through the directories.
for folder in $(ls -d "$base_dir"/*[0-9]*/ | sort -V); do
    name=$(basename "$folder" | sed 's/[0-9].*//')

    echo -e "\033[1m\033[94mC files executed for $name\033[0m\n"

    c_files_directly_in_folder=false
    c_files_in_subfolder=false

    if ls "$folder"/*.c 1> /dev/null 2>&1; then
        c_files_directly_in_folder=true
    fi

    if find "$folder" -mindepth 2 -type f -name "*.c" | read; then
        c_files_in_subfolder=true
    fi

    if $c_files_directly_in_folder || $c_files_in_subfolder; then
        c_files=$(find "$folder" -type f -name "*.c" | sort -V)
        for c_file in $c_files; do
            basename="${c_file##*/}"
            executable="${c_file%.c}"
            check_file="check${basename%.c}.py"
            
            if [[ "$basename" =~ ^[0-9]+\.c$ ]]; then
                echo -e "\033[94mFile name: $basename\033[0m"
            else
                echo -e "\033[38;5;214mFile name: $basename\033[0m"
            fi
            echo "Compiling \"$c_file\" in $name"
            clang "$c_file" -w -o "$executable"

            if [[ -f "$executable" ]]; then
                input_files=$(find "./" -type f -name "${basename%.c}-*.txt" | sort -V)
                
                for input_file in $input_files; do
                    input_suffix=$(basename "$input_file" .txt | sed "s/.*-//")
                    output_file="${executable}-${input_suffix}_out.txt"
                    
                    if [[ -f "$input_file" ]]; then
                        "$executable" < "$input_file" > "$output_file"
                    else
                        "$executable" > "$output_file"
                    fi

                    printf "\n"
                    
                    # Variable to track if a match has been found
                    match_found=false
                    partial_found=false

                    # Loop through potential expected output files including alternative versions
                    for expected_file in "$script_dir"/a${basename%.c}-${input_suffix}*.txt; do
                        
                        # Full answers
                        if diff <(awk '{$1=$1}1' "$output_file") <(awk '{$1=$1}1' "$expected_file") > /dev/null; then
                            # Partial answers
                            if [[ $expected_file =~ ^.*_part(_[0-9]+)?\.txt$ ]]; then
                                partial_found=true
                                match_found=true
                                echo -e "\033[38;5;214mThe output partially matches with $(basename "$expected_file").\033[0m"
                            else
                                match_found=true
                                echo -e "\033[92mThe output matches with $(basename "$expected_file").\033[0m"
                                break # Stop the loop once a match is found
                            fi
                        fi
                    done

                    # Check if no match was found after the loop
                    if ! $match_found; then
                        echo -e "\033[91mThe output for input file $(basename "$input_file") does not match any of the expected outputs.\033[0m"
                        cat "$output_file"
                    fi
                done

                if [[ -f "$script_dir/$check_file" ]]; then
                    python3 "$script_dir/$check_file" "$c_file"
                fi

            else
                echo "Compilation failed for \"$c_file\""
            fi

            printf "\n"
        done
    else
        echo "No C source files to compile in $name."
    fi
done
