#!/bin/bash

# Is ollama running?
curl http://localhost:11434/api/version > /dev/null 2>&1
# shellcheck disable=2181
if [ $? -ne 0 ]; then
    echo "'Ollama' is not running... Please install (if needed at 'https://ollama.com/') and run Ollama!"
    exit 1
fi

# setting up continue on vscode?
    # shellcheck disable=2162
    read -p "Do you want to configure Continue extention is VSCode? (yes/no) " answer
    if [[ "$answer" =~ ^[Yy][Ee][Ss]|[Yy]$ ]]; then
        echo "Downloading Ollama models..."
        curl http://localhost:11434/api/pull -d '{
          "model": "llama3.1",
          "stream": false
        }'
        curl http://localhost:11434/api/pull -d '{
          "model": "qwen2.5-coder:1.5b",
          "stream": false
        }'
        curl http://localhost:11434/api/pull -d '{
          "model": "qwen2.5-coder:7b",
          "stream": false
        }'
        curl http://localhost:11434/api/pull -d '{
          "model": "nomic-embed-text",
          "stream": false
        }'

        echo ""

        # https://docs.continue.dev/reference#data
        echo "Review the following configuration file for Continue extension in VSCode: '$(pwd)/template_config.yaml'"
        # shellcheck disable=2162
        read -p "Do you want push config file to local machine if it doesn't exist? (yes/no) " answer2
        if [[ "$answer2" =~ ^[Yy][Ee][Ss]|[Yy]$ ]]; then
            cp -c ./template_config.yaml ~/.continue/config.yaml
            echo "https://docs.continue.dev/customize/deep-dives/autocomplete#setting-up-with-ollama-default"
        fi



    fi

# If you want to expose to network
# launchctl setenv OLLAMA_HOST "0.0.0.0:11434" # 127.0.0.1

docker compose up -d
open http://localhost:8080

# docker compose down --remove-orphans

# test ollama endpoint

# get ollama version
curl http://localhost:11434/api/version

# test ollama prompt to get compute utilization
curl http://localhost:11434/api/generate -d '{
  "model": "llama3.2",
  "prompt": "Say hi",
  "stream": false
}'

# check GPU/CPU utilization
ollama ps
