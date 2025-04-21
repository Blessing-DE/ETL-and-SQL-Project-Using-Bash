#!/bin/bash

# Load DB config
source ./database.conf
export PGPASSWORD="$DB_PASSWORD"

# Set CSV directory
CSV_DIR="/c/Users/User/Documents/parch_and_posey"

# Loop through each CSV
for csv_file in "$CSV_DIR"/*.csv; do
  filename=$(basename -- "$csv_file")
  table_name="${filename%.*}"

  echo "📥 Importing $filename into table: $table_name"

  # Convert path to Windows format for psql
  win_path=$(cygpath -w "$csv_file")

  # Use \COPY with Windows path
  psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" \
    -c "\COPY $table_name FROM '$win_path' WITH (FORMAT csv, HEADER true)"

  if [ $? -eq 0 ]; then
    echo "✅ Successfully imported $filename"
  else
    echo "❌ Failed to import $filename"
  fi
done

echo "✅ All files processed."


