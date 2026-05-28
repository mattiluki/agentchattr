#!/usr/bin/env sh
# agentchattr - starts server (if not running) + Qwen agent wrapper
cd "$(dirname "$0")/.."

# Ensure server is running
# ... (standard agentchattr server start check)

.venv/bin/python wrapper.py qwen
