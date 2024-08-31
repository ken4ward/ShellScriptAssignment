#!/bin/bash

# Function to save JSON data to a CSV file
save_to_csv() {
    local json_data=$1
    local output_file=$2

    # Create CSV header
    header="id,name,username,email,phone,website,company_name,company_catchPhrase,company_bs"
    echo $header > $output_file

    # Parse JSON and append to CSV
    echo "$json_data" | jq -r '.[] | [.id, .name, .username, .email, .phone, .website, .company.name, .company.catchPhrase, .company.bs] | @csv' >> $output_file

    if [ $? -eq 0 ]; then
        echo "Users data has been saved to $output_file"
    else
        log_error "Failed to write data to $output_file"
        exit 1
    fi
}
