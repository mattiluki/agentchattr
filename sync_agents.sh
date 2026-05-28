#!/bin/bash
# Sync agents: kill wrappers that aren't in config.toml, restart run.py

CONFIG="/Users/zeroclaw/Documents/agentchattr/config.toml"
WRAPPER_DIR="/Users/zeroclaw/Documents/agentchattr"

echo "Syncing agent processes with $CONFIG..."

# Get list of agents from config (excluding commented ones)
AGENTS=$(grep '^\[agents\.' "$CONFIG" | sed 's/\[agents\.\(.*\)\]/\1/')

# 1. Kill wrappers not in the list
for pid in $(ps aux | grep "[w]rapper.py" | awk '{print $2}'); do
    # Find which agent this wrapper is running
    AGENT_NAME=$(ps -fp $pid | sed -n 's/.*wrapper\.py //p')
    if [[ -n "$AGENT_NAME" ]]; then
        if ! echo "$AGENTS" | grep -q "^$AGENT_NAME$"; then
            echo "Killing orphaned wrapper for agent: $AGENT_NAME (PID: $pid)"
            kill $pid
        fi
    fi
done

# 2. Restart run.py
echo "Restarting run.py server..."
pkill -f "run.py"
cd "$WRAPPER_DIR" && nohup .venv/bin/python run.py > data/server.log 2>&1 &
echo "Done."
