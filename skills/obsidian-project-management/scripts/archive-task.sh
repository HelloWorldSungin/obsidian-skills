#!/bin/bash

# Archive a completed task
# Usage: archive-task.sh --id=TASK-001

# Configuration
VAULT_PATH="/Users/sunginkim/Documents/Obsidian Vault"
TASKS_DIR="$VAULT_PATH/TaskNotes/Tasks"
ARCHIVE_DIR="$VAULT_PATH/TaskNotes/Archive"

# Parameters
TASK_ID=""

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --id=*)
      TASK_ID="${1#*=}"
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Validate
if [[ -z "$TASK_ID" ]]; then
  echo "Error: --id is required"
  echo "Usage: archive-task.sh --id=TASK-001"
  exit 1
fi

# Find task file
TASK_FILE=$(find "$TASKS_DIR" -name "${TASK_ID}-*.md" -type f 2>/dev/null | head -1)

if [[ -z "$TASK_FILE" ]]; then
  echo "Error: Task not found: $TASK_ID"
  exit 1
fi

# Create archive directory
mkdir -p "$ARCHIVE_DIR"

# Move file
FILENAME=$(basename "$TASK_FILE")
mv "$TASK_FILE" "$ARCHIVE_DIR/$FILENAME"

# Update status to done if not already
if ! grep -q "^status: done" "$ARCHIVE_DIR/$FILENAME"; then
  sed -i '' 's/^status: .*/status: done/' "$ARCHIVE_DIR/$FILENAME"
fi

echo "✓ Archived $TASK_ID to TaskNotes/Archive/"
echo "  Note: TaskNotes can auto-archive completed tasks via plugin settings"
