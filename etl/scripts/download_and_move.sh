#!/bin/bash

# Define directories (these will be created if they don't exist)
WORK_DIR="$HOME/source_folder"  # Folder to store downloaded files
DEST_DIR="$HOME/json_and_CSV"   # Folder to move the files to

# Create the source and destination folders if they don't exist
mkdir -p "$WORK_DIR"
mkdir -p "$DEST_DIR"

# URLs to download the files from
CSV_URL="https://people.sc.fsu.edu/~jburkardt/data/csv/airtravel.csv"
JSON_URL="https://jsonplaceholder.typicode.com/users"

# Download the CSV and JSON files to the source folder
curl -o "$WORK_DIR/airtravel.csv" "$CSV_URL"  # Download CSV
curl -o "$WORK_DIR/users.json" "$JSON_URL"    # Download JSON

# Move the downloaded files to the destination folder
mv "$WORK_DIR"/*.csv "$DEST_DIR" 2>/dev/null   # Move CSV files
mv "$WORK_DIR"/*.json "$DEST_DIR" 2>/dev/null  # Move JSON files

# Print a message to confirm the action is complete
echo "CSV and JSON files have been downloaded and moved to $DEST_DIR"

