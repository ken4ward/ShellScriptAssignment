#!/bin/bash

# Load dependencies
source ./../shared/api_request.sh
source ./csv_handler.sh
source ./utils.sh
source ./../shared/constants.sh

# Ensure the data directory exists
mkdir -p "$OUTPUT_DIR"

# Fetch data from the API
json_data=$(fetch_users_data "$API_URL")

# Check for errors in fetching data
if [ $? -ne 0 ]; then
    log_error "Failed to fetch data from the API"
    exit 1
fi

# Save data to CSV in the data directory
save_to_csv "$json_data" "$OUTPUT_FILE"
