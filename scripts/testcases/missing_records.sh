#!/bin/bash

# Source the API request function and logging function
source ./scripts/shared/constants.sh
source ./scripts/shared/log_test_result.sh
source ./scripts/shared/api_request.sh

# Define the bold text color
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

# Print the header at the beginning of the test run
echo "${BOLD}MISSING RECORDS TESTCASE${NORMAL}"

# URL of the API
api_url=$API_URL

# Fetch data from the API
api_data=$(fetch_users_data $api_url)

# Define the path to the CSV file
csv_file=$MISSING_RECORDS

# Read the CSV file
while IFS=, read -r id name username email phone website company_name company_catchPhrase company_bs
do
    # Skip the header
    if [ "$id" == "id" ]; then
        continue
    fi

    # Clean up the data to remove extra quotes and spaces
    expected_data=$(echo "$id, $name, $username, $email, $phone, $website, $company_name, $company_catchPhrase, $company_bs" | sed 's/"//g')

    # Check if the record exists in API data
    if echo "$api_data" | grep -q "\"id\": $id"; then
        # Extract actual data from API response
        actual_data=$(echo "$api_data" | jq -r --argjson id "$id" '
            .[] | select(.id == $id) |
            "\(.id), \(.name), \(.username), \(.email), \(.phone), \(.website), \(.company.name), \(.company.catchPhrase), \(.company.bs)"
        ' | sed 's/"//g')

        # Compare expected and actual data
        if [ "$expected_data" == "$actual_data" ]; then
            actual_data="RECORDS MATCHED"
            status="Pass"
        else
            actual_data="MISMATCH"
            status="Fail"
        fi
    else
        actual_data="Record not found in API"
        status="Fail"
    fi

    # Log the test result
    log_test_result "TC$id" "Validate record for ID $id" "RECORDS CHECK" "$actual_data" "$status"

done < "$csv_file"
