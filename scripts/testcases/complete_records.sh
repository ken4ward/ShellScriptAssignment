#!/bin/bash

# Source the shared functions
source ./scripts/shared/constants.sh
source ./scripts/shared/log_test_result.sh
source ./scripts/shared/api_request.sh

# Function to print a bold header
print_bold_header() {
    local header_text=$1
    # Bold text escape code
    local bold='\033[1m'
    local reset='\033[0m'
    echo -e "${bold}${header_text}${reset}"
}

# Print the bold header
print_bold_header "COMPLETE RECORDS TESTCASE"

# Path to the CSV file
CSV_FILE=$INPUT_FILE

# API URL
API_URL=$API_URL

# Fetch data from the API
api_data=$(fetch_users_data $API_URL)

# Function to get a specific user data from API response
get_api_user_data() {
    local user_id=$1
    echo "$api_data" | jq -r --argjson id "$user_id" '
        .[] | select(.id == $id) |
        "\(.id), \(.name), \(.username), \(.email), \(.phone), \(.website), \(.company.name), \(.company.catchPhrase), \(.company.bs)"'
}

# Read CSV file and compare records
while IFS=',' read -r id name username email phone website company_name company_catchPhrase company_bs; do
    if [ "$id" != "id" ]; then  # Skip the header
        # Clean up the data to remove extra quotes and spaces
        expected_data=$(echo "$id, $name, $username, $email, $phone, $website, $company_name, $company_catchPhrase, $company_bs" | sed 's/"//g')

        # Fetch the actual data for the given ID
        actual_data=$(get_api_user_data "$id")

        # Clean up the data to remove extra quotes and spaces
        actual_data=$(echo "$actual_data" | sed 's/"//g')

        # Check if actual data is empty (record not found)
        if [ -z "$actual_data" ]; then
            actual_data="Record not found in API"
            status="Fail"
        elif [ "$expected_data" == "$actual_data" ]; then
            actual_data="RECORDS MATCHED"
            status="Pass"
        else
            actual_data="MISMATCH"
            status="Fail"
        fi

        # Log the test result
        log_test_result "TC$id" "Validate record for ID $id" "RECORDS CHECK" "$actual_data" "$status"
    fi
done < $CSV_FILE

