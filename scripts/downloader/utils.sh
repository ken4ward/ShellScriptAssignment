#!/bin/bash

# Function to log errors
log_error() {
    local message=$1
    echo "ERROR: $message" >&2
}
