# ai_sidekick

A CLI tool for configuring Ollama models, the Continue extension for VSCode, and Open WebUI

## Features
- Auto-configures Ollama model pulling
- Sets up Continue extension with default configuration
- Validates Ollama server availability
- Handles model versioning and configuration

## Prerequisites
- Ollama installed (https://ollama.com/)
- Docker installed
- Python 3.9.6+ for pre-commit hooks

## Quick Start
1. Make the script executable:
```bash
chmod +x run.sh
```

Run the setup script:
```bash
./run.sh
```

Follow the prompts to:
- Configure Ollama server
- Pull required models
- Set up Continue extension
