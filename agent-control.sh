#!/bin/bash
# agent-control.sh <action: load|unload> <agent_name>
# Manage agent lifecycle via launchd and process cleanup.

ACTION=$1
AGENT=$2
PLIST_DIR="$HOME/Library/LaunchAgents"
PLIST="$PLIST_DIR/com.user.agentchattr-$AGENT.plist"

if [ -z "$ACTION" ] || [ -z "$AGENT" ]; then
    echo "Usage: $0 <load|unload> <agent_name>"
    exit 1
fi

if [ ! -f "$PLIST" ]; then
    echo "Error: Plist not found at $PLIST"
    exit 1
fi

case $ACTION in
    load)
        echo "Loading $AGENT..."
        launchctl load -w "$PLIST"
        echo "Agent $AGENT loaded."
        ;;
    unload)
        echo "Unloading $AGENT..."
        launchctl unload -w "$PLIST"
        pkill -f "wrapper.py $AGENT"
        pkill -f "wrapper_api.py $AGENT"
        echo "Agent $AGENT stopped and removed from startup."
        ;;
    *)
        echo "Invalid action: $ACTION. Use 'load' or 'unload'."
        exit 1
        ;;
esac
