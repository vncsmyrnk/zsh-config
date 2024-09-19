#!/bin/zsh

jwt_token=$1

if [ -z "$jwt_token" ]; then
  echo "Usage: decode-jwt <jwt>"
  exit 1
fi

payload=$(echo "$jwt_token" | cut -d "." -f2)
decoded_payload=$(echo "$payload" | tr '_-' '/+' | base64 -d 2>/dev/null | jq '.')
echo $decoded_payload
