#!/bin/bash

# log_test_result.sh

# Function to log test results in a standardized format
log_test_result() {
    local test_case_id=$1
    local test_description=$2
    local expected_result=$3
    local actual_result=$4
    local status=$5
    local defect_id=$6
    local tested_by=$7
    local date_of_test=$8
    local comments=$9

    # Print the header if it's the first log
    if [ ! -f test_report.log ]; then
        echo -e "Test Case ID\tTest Description\t\tExpected Result\t\tActual Result\t\tStatus\tDefect ID\tTested By\tDate of Test\tComments/Notes" > test_report.log
        echo -e "=======================================================================================================================================" >> test_report.log
    fi

    # Log the test result
    echo -e "$test_case_id\t$test_description\t$expected_result\t$actual_result\t$status\t$defect_id\t$tested_by\t$date_of_test\t$comments" >> test_report.log
}

# Example usage of the function (uncomment for testing)
# log_test_result "TC001" "Login with valid credentials" "User is logged in" "User is logged in" "Pass" "-" "John Doe" "2024-09-02" "N/A"
