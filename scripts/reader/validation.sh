#!/bin/bash

# Function to log errors
log_error() {
    local message=$1
    echo "ERROR: $message" >> error.log
}

# Function to validate data
validate_data() {
    local id=$1
    local name=$2
    local username=$3
    local email=$4
    local phone=$5
    local website=$6
    local company_name=$7
    local company_catchPhrase=$8
    local company_bs=$9

    local api_name=${10}
    local api_username=${11}
    local api_email=${12}
    local api_phone=${13}
    local api_website=${14}
    local api_company_name=${15}
    local api_company_catchPhrase=${16}
    local api_company_bs=${17}

    if [ "$name" != "$api_name" ]; then
        echo "Test Failed: Name mismatch for user ID $id"
        echo "Expected: $name, Got: $api_name"
    elif [ "$username" != "$api_username" ]; then
        echo "Test Failed: Username mismatch for user ID $id"
        echo "Expected: $username, Got: $api_username"
    elif [ "$email" != "$api_email" ]; then
        echo "Test Failed: Email mismatch for user ID $id"
        echo "Expected: $email, Got: $api_email"
    elif [ "$phone" != "$api_phone" ]; then
        echo "Test Failed: Phone mismatch for user ID $id"
        echo "Expected: $phone, Got: $api_phone"
    elif [ "$website" != "$api_website" ]; then
        echo "Test Failed: Website mismatch for user ID $id"
        echo "Expected: $website, Got: $api_website"
    elif [ "$company_name" != "$api_company_name" ]; then
        echo "Test Failed: Company Name mismatch for user ID $id"
        echo "Expected: $company_name, Got: $api_company_name"
    elif [ "$company_catchPhrase" != "$api_company_catchPhrase" ]; then
        echo "Test Failed: Company CatchPhrase mismatch for user ID $id"
        echo "Expected: $company_catchPhrase, Got: $api_company_catchPhrase"
    elif [ "$company_bs" != "$api_company_bs" ]; then
        echo "Test Failed: Company BS mismatch for user ID $id"
        echo "Expected: $company_bs, Got: $api_company_bs"
    else
        echo "Test Passed: Data matches for user ID $id"
    fi
}
