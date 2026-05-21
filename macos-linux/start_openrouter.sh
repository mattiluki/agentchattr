#!/usr/bin/env sh
# agentchattr — starts server (if not running) + OpenRouter API agent wrapper
cd "$(dirname "$0")/.."
exec sh macos-linux/start_api_agent.sh openrouter
