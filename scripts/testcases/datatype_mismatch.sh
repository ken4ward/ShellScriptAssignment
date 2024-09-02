#!/bin/bash

source ./../shared/constants.sh
source ./../shared/log_test_result.sh

# Define the CSV file
CSV_FILE=$DATA_MISMATCH

# Define the log file path
LOG_DIR=$TEST_REPORTS
LOG_FILE="${LOG_DIR}test_report.log"

# Check if the log file exists and delete it
if [ -f "$LOG_FILE" ]; then
    rm "$LOG_FILE"
    echo "Deleted existing log file: $LOG_FILE"
fi

# Print the header at the beginning of the log file and console
echo -e "\033[1;37;44mDATA TYPE MISMATCH TESTCASE\033[0m" | tee -a "$LOG_FILE"

# Create a new log file and add a header
log_test_result "Test Case ID" "Test Description" "Expected Result" "Actual Result" "Status"

# Read the CSV file line by line
while IFS=',' read -r id name username email phone website company_name company_catchPhrase company_bs; do
    # Skip the header
    if [[ "$id" == "id" ]]; then
        continue
    fi

    # Check for datatype mismatches
    mismatch_found=false

    # Check id field (should be integer)
    if ! [[ "$id" =~ ^[0-9]+$ ]]; then
        log_test_result "$id" "ID should be an integer" "Integer" "$id (String)" "Fail"
        mismatch_found=true
    fi

    # Check phone field (should not include parentheses in extension)
    if [[ "$phone" =~ \(|\) ]]; then
        log_test_result "$id" "Phone number should not include parentheses" "No parentheses" "$phone" "Fail"
        mismatch_found=true
    fi

    # Check website field (should not include parentheses, for consistency)
    if [[ "$website" =~ \(|\) ]]; then
        log_test_result "$id" "Website should not include parentheses" "No parentheses" "$website" "Fail"
        mismatch_found=true
    fi

    # Log a success message if no mismatch was found
    if [ "$mismatch_found" = false ]; then
        log_test_result "$id" "No datatype mismatch detected" "None" "None" "Pass"
    fi

done < "$CSV_FILE"
