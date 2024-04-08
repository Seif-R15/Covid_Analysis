#!/bin/bash

# Set environment variables if necessary
# export HADOOP_HOME=/path/to/hadoop
# export HIVE_HOME=/path/to/hive

# Specify the output CSV file path
output_file="/home/cloudera/COVID_FINAL_OUTPUT/output.csv"

# Hive query to export table to CSV
hive -e "SELECT * FROM covid_db.covid_final_output" > "$output_file"

# Check if the file was created successfully
if [ -f "$output_file" ]; then
    echo "Table successfully exported to CSV file: $output_file"
else
    echo "Error: Failed to export table to CSV file."
fi

covid_final_output
