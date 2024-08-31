#!/bin/bash

tail -n +2 $INPUT_FILE | while IFS=, read -r id name username email phone website company_name company_catchPhrase company_bs
do
    # Remove double quotes from the CSV values
    # shellcheck disable=SC2001
    name=$(echo $name | sed 's/^"\(.*\)"$/\1/')
    # shellcheck disable=SC2001
    username=$(echo $username | sed 's/^"\(.*\)"$/\1/')
    # shellcheck disable=SC2001
    email=$(echo $email | sed 's/^"\(.*\)"$/\1/')
    # shellcheck disable=SC2001
    phone=$(echo $phone | sed 's/^"\(.*\)"$/\1/')
    # shellcheck disable=SC2001
    website=$(echo $website | sed 's/^"\(.*\)"$/\1/')
    # shellcheck disable=SC2001
    company_name=$(echo $company_name | sed 's/^"\(.*\)"$/\1/')
    # shellcheck disable=SC2001
    company_catchPhrase=$(echo "$company_catchPhrase" | sed 's/^"\(.*\)"$/\1/')
    # shellcheck disable=SC2001
    company_bs=$(echo $company_bs | sed 's/^"\(.*\)"$/\1/')

    # Fetch data from the API for the given user ID
    api_response=$(fetch_users_data "$API_URL/$id")

    if [ $? -ne 0 ]; then
        log_error "Failed to fetch data for user ID $id"
        continue
    fi

    # Extract fields from the API response
    api_name=$(echo "$api_response" | jq -r '.name')
    api_username=$(echo "$api_response" | jq -r '.username')
    api_email=$(echo "$api_response" | jq -r '.email')
    api_phone=$(echo "$api_response" | jq -r '.phone')
    api_website=$(echo "$api_response" | jq -r '.website')
    api_company_name=$(echo "$api_response" | jq -r '.company.name')
    api_company_catchPhrase=$(echo "$api_response" | jq -r '.company.catchPhrase')
    api_company_bs=$(echo "$api_response" | jq -r '.company.bs')

    # Validation checks
    validate_data "$id" "$name" "$username" "$email" "$phone" "$website" "$company_name" "$company_catchPhrase" "$company_bs" \
                  "$api_name" "$api_username" "$api_email" "$api_phone" "$api_website" "$api_company_name" \
                  "$api_company_catchPhrase" "$api_company_bs"
done
