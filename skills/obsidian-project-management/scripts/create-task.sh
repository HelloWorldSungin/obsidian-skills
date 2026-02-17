#!/bin/bash

# Create a new task in TaskNotes/Tasks/
# Usage: create-task.sh --title="Task Title" --project="trading-signal-ai" [options]

# Configuration
VAULT_PATH="/Users/sunginkim/Documents/Obsidian Vault"
TASKS_DIR="$VAULT_PATH/TaskNotes/Tasks"
META_DIR="$VAULT_PATH/TaskNotes/meta"
COUNTER_FILE="$META_DIR/task-counter"
TEMPLATE_FILE="$HOME/.config/opencode/skills/obsidian-project-management/templates/task-template.md"

# Default values
TITLE=""
PROJECT=""
WORK_TYPE=""
COMPONENT="none"
PRIORITY="medium"
URGENCY="normal"
DUE=""
SCHEDULED=""
SESSION=""
DESCRIPTION=""
RELATED="[]"

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --title=*)
      TITLE="${1#*=}"
      shift
      ;;
    --project=*)
      PROJECT="${1#*=}"
      shift
      ;;
    --work-type=*)
      WORK_TYPE="${1#*=}"
      shift
      ;;
    --component=*)
      COMPONENT="${1#*=}"
      shift
      ;;
    --priority=*)
      PRIORITY="${1#*=}"
      shift
      ;;
    --urgency=*)
      URGENCY="${1#*=}"
      shift
      ;;
    --due=*)
      DUE="${1#*=}"
      shift
      ;;
    --scheduled=*)
      SCHEDULED="${1#*=}"
      shift
      ;;
    --session=*)
      SESSION="${1#*=}"
      shift
      ;;
    --description=*)
      DESCRIPTION="${1#*=}"
      shift
      ;;
    --related=*)
      RELATED="${1#*=}"
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Validate required fields
if [[ -z "$TITLE" ]]; then
  echo "Error: --title is required"
  exit 1
fi

# Ensure directories exist
mkdir -p "$TASKS_DIR"
mkdir -p "$META_DIR"

# Get next task ID
if [[ -f "$COUNTER_FILE" ]]; then
  COUNTER=$(cat "$COUNTER_FILE")
else
  COUNTER=1
fi

TASK_ID=$(printf "TASK-%03d" "$COUNTER")

# Create slug from title (lowercase, replace spaces with hyphens, remove special chars)
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')

# Create filename
FILENAME="${TASK_ID}-${SLUG}.md"
FILEPATH="$TASKS_DIR/$FILENAME"

# Check if file already exists
if [[ -f "$FILEPATH" ]]; then
  echo "Error: Task file already exists: $FILENAME"
  exit 1
fi

# Get current date
CREATED=$(date +%Y-%m-%d)

# Read template and substitute variables
cp "$TEMPLATE_FILE" "$FILEPATH"

# Use sed to replace template variables
sed -i '' "s/{{title}}/$TITLE/g" "$FILEPATH"
sed -i '' "s/{{task_id}}/$TASK_ID/g" "$FILEPATH"
sed -i '' "s/{{priority}}/$PRIORITY/g" "$FILEPATH"
sed -i '' "s/{{project}}/$PROJECT/g" "$FILEPATH"
sed -i '' "s/{{work_type}}/$WORK_TYPE/g" "$FILEPATH"
sed -i '' "s/{{component}}/$COMPONENT/g" "$FILEPATH"
sed -i '' "s/{{urgency}}/$URGENCY/g" "$FILEPATH"
sed -i '' "s/{{due}}/$DUE/g" "$FILEPATH"
sed -i '' "s/{{scheduled}}/$SCHEDULED/g" "$FILEPATH"
sed -i '' "s/{{session}}/$SESSION/g" "$FILEPATH"
sed -i '' "s/{{description}}/$DESCRIPTION/g" "$FILEPATH"
sed -i '' "s/{{related}}/$RELATED/g" "$FILEPATH"
sed -i '' "s/{{created}}/$CREATED/g" "$FILEPATH"

# Increment counter
NEXT_COUNTER=$((COUNTER + 1))
echo "$NEXT_COUNTER" > "$COUNTER_FILE"

echo "✓ Created task: $FILENAME"
echo "  Title: $TITLE"
echo "  ID: $TASK_ID"
echo "  Status: backlog"
echo "  Project: $PROJECT"
echo "  Priority: $PRIORITY"
echo ""
echo "  Location: TaskNotes/Tasks/$FILENAME"
