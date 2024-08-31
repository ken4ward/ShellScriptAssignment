#!/bin/bash

# Function to fetch users data
fetch_users_data() {
    local url=$1
    curl -s "$url"
}
