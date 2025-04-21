#!/bin/bash

# Set base directory
BASE_DIR="$HOME/Documents/linux_bash_git"

# Create necessary folders
mkdir -p "$BASE_DIR/raw"
mkdir -p "$BASE_DIR/Transformed"
mkdir -p "$BASE_DIR/Gold"

# Define the download URL
DOWNLOAD_URL="https://www.mbie.govt.nz/assets/annual-enterprise-survey-2023-financial-year-provisional-csv.csv"

# Define the download path
OUTPUT_FILE="$BASE_DIR/raw/annual-enterprise-survey-2023-financial-year-provisional.csv"

# Step 1: Download the file
echo "Downloading file from the internet..."
curl -o "$OUTPUT_FILE" "$DOWNLOAD_URL"

# Check if download was successful
if [ $? -eq 0 ]; then
    echo "File downloaded successfully to $OUTPUT_FILE."
else
    echo "Failed to download the file."
    exit 1
fi

# Step 2: Transform the data
echo "Transforming the data..."

INPUT_FILE="$OUTPUT_FILE"
TRANSFORMED_FILE="$BASE_DIR/Transformed/2023_year_finance.csv"

# Use awk to rename the header and extract selected columns
awk -F',' 'BEGIN {OFS=","} NR==1 {
    gsub(/Variable_code/, "variable_code");
    print $1,$5,$6,$9
} NR>1 {print $1,$5,$6,$9}' "$INPUT_FILE" > "$TRANSFORMED_FILE"

# Check transformation success
if [ $? -eq 0 ]; then
    echo "Data transformation complete. Saved to $TRANSFORMED_FILE."
else
    echo "Data transformation failed."
    exit 1
fi

# Step 3: Move the transformed file to the Gold folder
echo "Moving the transformed file to the 'Gold' folder..."

mv "$TRANSFORMED_FILE" "$BASE_DIR/Gold/"

# Verify the file exists in the Gold folder
if [ -f "$BASE_DIR/Gold/2023_year_finance.csv" ]; then
    echo "File successfully moved to Gold folder."
else
    echo "Failed to move the file to Gold folder."
    exit 1
fi

echo "🎉 ETL process completed successfully"
