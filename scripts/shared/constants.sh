#!/bin/bash

# Path to the input CSV file
# shellcheck disable=SC2034
INPUT_FILE="./data/users.csv"
DATA_MISMATCH="./data/datatype_mismatch.csv"
MISSING_RECORDS="./data/missing_records.csv"
TEST_REPORTS="./reports/"

# URL for the API endpoint
API_URL="https://jsonplaceholder.typicode.com/users"

# Log file for errors
ERROR_LOG="./../../logs/error/"

# Path to the dependencies
API_REQUEST_SCRIPT="./../shared/api_request.sh"

UTILS_SCRIPT="./../downloader/utils.sh"

# File to store the results
RESULTS_FILE="./results.txt"

# Directory and file paths for output
OUTPUT_DIR="./../../data"
OUTPUT_FILE="$OUTPUT_DIR/users.csv"


