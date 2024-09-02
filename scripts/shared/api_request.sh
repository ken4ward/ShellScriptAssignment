#!/bin/bash

# Function to fetch user data from the API
fetch_users_data() {
    local url=$1
    curl -s $url
}
