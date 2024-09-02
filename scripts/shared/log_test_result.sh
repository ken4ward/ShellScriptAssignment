#!/bin/bash

REPORT=$TEST_REPORTS

# Function to log test results in a standardized format
log_test_result() {
    local test_case_id=$1
    local test_description=$2
    local expected_result=$3
    local actual_result=$4
    local status=$5

    # Define column widths
    local col1_width=15   # Test Case ID
    local col2_width=40   # Test Description
    local col3_width=30   # Expected Result
    local col4_width=50   # Actual Result
    local col5_width=10   # Status

    # Format the row
    local formatted_row=$(printf "| %-${col1_width}s | %-${col2_width}s | %-${col3_width}s | %-${col4_width}s | %-${col5_width}s |" \
        "$test_case_id" "$test_description" "$expected_result" "$actual_result" "$status")

    # Define header separator
    local header_separator="+-%-${col1_width}s-+-%-${col2_width}s-+-%-${col3_width}s-+-%-${col4_width}s-+-%-${col5_width}s-+"

    # Print header if this is the first entry
    if [ -z "$HEADER_PRINTED" ]; then
        # Print the header row with full width separator
        printf "$header_separator\n" \
            "$(printf '%0.s-' $(seq 1 $col1_width))" \
            "$(printf '%0.s-' $(seq 1 $col2_width))" \
            "$(printf '%0.s-' $(seq 1 $col3_width))" \
            "$(printf '%0.s-' $(seq 1 $col4_width))" \
            "$(printf '%0.s-' $(seq 1 $col5_width))"
        printf "| %-${col1_width}s | %-${col2_width}s | %-${col3_width}s | %-${col4_width}s | %-${col5_width}s |\n" \
            "Test Case ID" "Test Description" "Expected Result" "Actual Result" "Status"
        printf "$header_separator\n" \
            "$(printf '%0.s-' $(seq 1 $col1_width))" \
            "$(printf '%0.s-' $(seq 1 $col2_width))" \
            "$(printf '%0.s-' $(seq 1 $col3_width))" \
            "$(printf '%0.s-' $(seq 1 $col4_width))" \
            "$(printf '%0.s-' $(seq 1 $col5_width))"
        HEADER_PRINTED=true
    fi

    # Print the test result to console
    echo "$formatted_row"
}

# Example usage of the function (uncomment for testing)
# log_test_result "TC001" "Login with valid credentials" "User is logged in" "User is logged in" "Pass"
