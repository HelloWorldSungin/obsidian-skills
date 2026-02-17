#!/bin/bash

# Update task properties
# Usage: update-task.sh --id=TASK-001 --field=status --value="in-progress"

# Configuration
VAULT_PATH="/Users/sunginkim/Documents/Obsidian Vault"
TASKS_DIR="$VAULT_PATH/TaskNotes/Tasks"

# Parameters
TASK_ID=""
FIELD=""
VALUE=""

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --id=*)
      TASK_ID="${1#*=}"
      shift
      ;;
    --field=*)
      FIELD="${1#*=}"
      shift
      ;;
    --value=*)
      VALUE="${1#*=}"
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Validate
if [[ -z "$TASK_ID" || -z "$FIELD" || -z "$VALUE" ]]; then
  echo "Error: --id, --field, and --value are required"
  echo "Usage: update-task.sh --id=TASK-001 --field=status --value=\"in-progress\""
  exit 1
fi

# Find task file
TASK_FILE=$(find "$TASKS_DIR" -name "${TASK_ID}-*.md" -type f 2>/dev/null | head -1)

if [[ -z "$TASK_FILE" ]]; then
  echo "Error: Task not found: $TASK_ID"
  exit 1
fi

# Update the field in frontmatter
if grep -q "^$FIELD:" "$TASK_FILE"; then
  # Field exists, update it
  if [[ "$FIELD" == "title" || "$FIELD" == "project" || "$FIELD" == "session" ]]; then
    # Quoted fields
    sed -i '' "s/^$FIELD: \"[^\"]*\"/$(echo "$FIELD: \"$VALUE\"" | sed 's/\//\\\//g')/" "$TASK_FILE"
  else
    # Unquoted fields
    sed -i '' "s/^$FIELD: .*/$(echo "$FIELD: $VALUE" | sed 's/\//\\\//g')/" "$TASK_FILE"
  fi
  echo "✓ Updated $TASK_ID: $FIELD = $VALUE"
else
  echo "Error: Field '$FIELD' not found in task frontmatter"
  exit 1
fi
