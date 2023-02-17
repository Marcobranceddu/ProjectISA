#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid
rm -f /dbg-events/tmp/pids/server.pid

# Then exec the container's main process
exec "$@"