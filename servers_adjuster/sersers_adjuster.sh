#!/bin/bash

# Specify array of servers
SERVERS=(10.10.0.30 10.10.0.34)

# Iterate over each server
for SERVER in "${SERVERS[@]}"; do
  # Connect to server and create empty file
  ssh -t username@$SERVER "command-to-execute-on-server"
done
