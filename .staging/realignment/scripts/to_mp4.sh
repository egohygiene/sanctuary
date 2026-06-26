#!/usr/bin/env bash
# @Project: Video Conversion Script
# @Author: szmyty
# @Description: This script converts video files to MP4 format using ffmpeg. 
# It checks if the input file is a video file, handles naming conflicts by 
# appending '_converted' to the filename if necessary.

# Function to display script usage
usage() {
    echo "Usage: $0 <input_video_file>"
    echo "Converts the specified video file to MP4 format."
    exit 1
}

# Function to check if the input file is a video
is_video_file() {
    local file="$1"
    local mime_type
    mime_type=$(file --mime-type -b "$file")
    case "$mime_type" in
        video/*) return 0 ;;
        *) return 1 ;;
    esac
}

# Function to generate output file name
generate_output_file_name() {
    local input="$1"
    local extension="${input##*.}"
    local base_name="${input%.*}"

    if [[ "$extension" == "mp4" ]]; then
        output_file="${base_name}_converted.mp4"
    else
        output_file="${base_name}.mp4"
    fi
}

# Function to convert video file to MP4
convert_to_mp4() {
    local input_file="$1"
    local output_file=""

    # Check if the input file exists
    if [[ ! -f "$input_file" ]]; then
        echo "Error: Input file '$input_file' does not exist."
        exit 1
    fi

    # Check if the input file is a video file
    if ! is_video_file "$input_file"; then
        echo "Error: '$input_file' is not a valid video file."
        exit 1
    fi

    # Generate the output file name
    generate_output_file_name "$input_file"

    # Perform the conversion using ffmpeg
    ffmpeg --nostdin --input "$input_file" --vcodec h264 --acodec aac --strict 2 "$output_file"

    # Check if the conversion was successful
    if [[ $? -eq 0 ]]; then
        echo "Conversion successful: '$input_file' -> '$output_file'"
    else
        echo "Error: Conversion failed."
        exit 1
    fi
}

# Check if the correct number of arguments is provided
if [[ $# -ne 1 ]]; then
    usage
fi

# Call the main function to convert the video file
convert_to_mp4 "$1"
