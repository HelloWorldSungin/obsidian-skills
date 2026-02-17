#!/bin/bash

# Create sub-tasks with automatic ID generation and parent linking
# Usage: task-create-subtask.sh --parent=TASK-007 --title="Subtask title" [--description="..."] [--work-type="..."]
#        task-create-subtask.sh --parent=TASK-007 --titles="Sub1, Sub2, Sub3" [--descriptions="Desc1, Desc2, Desc3"]

# Configuration
VAULT_PATH="/Users/sunginkim/Documents/Obsidian Vault"
TASKS_DIR="$VAULT_PATH/TaskNotes/Tasks"
EPIC_DIR="$VAULT_PATH/TaskNotes/Tasks/Epic"
STORY_DIR="$VAULT_PATH/TaskNotes/Tasks/Story"
TASK_TYPE_DIR="$VAULT_PATH/TaskNotes/Tasks"
TEMPLATE_FILE="$HOME/.config/opencode/skills/obsidian-project-management/templates/task-template.md"

# Parameters
PARENT=""
TITLE=""
DESCRIPTION=""
WORK_TYPE=""
TITLES=""
DESCRIPTIONS=""

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --parent=*)
      PARENT="${1#*=}"
      shift
      ;;
    --title=*)
      TITLE="${1#*=}"
      shift
      ;;
    --description=*)
      DESCRIPTION="${1#*=}"
      shift
      ;;
    --work-type=*)
      WORK_TYPE="${1#*=}"
      shift
      ;;
    --titles=*)
      TITLES="${1#*=}"
      shift
      ;;
    --descriptions=*)
      DESCRIPTIONS="${1#*=}"
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Validate parent
if [[ -z "$PARENT" ]]; then
  echo "Error: --parent is required"
  exit 1
fi

# Find parent task file
PARENT_FILE=$(find "$TASKS_DIR" -name "${PARENT}-*.md" -type f 2>/dev/null | head -1)
if [[ -z "$PARENT_FILE" ]]; then
  echo "Error: Parent task not found: $PARENT"
  exit 1
fi

# Get parent project/work-type for inheritance
PARENT_PROJECT=$(grep "^project:" "$PARENT_FILE" | sed 's/project: "//;s/"$//' | xargs)
PARENT_WORK_TYPE=$(grep "^work-type:" "$PARENT_FILE" | sed 's/work-type: "//;s/"$//' | xargs)
if [[ -z "$WORK_TYPE" && -n "$PARENT_WORK_TYPE" ]]; then
  WORK_TYPE="$PARENT_WORK_TYPE"
fi

# Ensure Sub-Tasks directory exists
mkdir -p "$SUBTASKS_DIR"

# Find existing sub-tasks and determine next number
EXISTING_SUBS=$(find "$SUBTASKS_DIR" -name "${PARENT}.*-*.md" -type f 2>/dev/null | wc -l)
NEXT_NUM=$((EXISTING_SUBS + 1))

# Function to create single sub-task
create_subtask() {
  local sub_title="$1"
  local sub_desc="$2"
  local sub_num="$3"
  
  SUB_ID="${PARENT}.${sub_num}"
  SLUG=$(echo "$sub_title" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-' | cut -c1-40)
  FILENAME="${SUB_ID}-${SLUG}.md"
  FILEPATH="$SUBTASKS_DIR/$FILENAME"
  
  if [[ -f "$FILEPATH" ]]; then
    echo "Warning: Task file already exists: $FILENAME"
    return 1
  fi
  
  # Copy and fill template
  cp "$TEMPLATE_FILE" "$FILEPATH"
  
  CREATED=$(date +%Y-%m-%d)
  
  # Replace template variables
  sed -i '' "s/{{title}}/$sub_title/g" "$FILEPATH"
  sed -i '' "s/{{task_id}}/$SUB_ID/g" "$FILEPATH"
  sed -i '' "s/{{priority}}/medium/g" "$FILEPATH"
  sed -i '' "s/{{project}}/$PARENT_PROJECT/g" "$FILEPATH"
  sed -i '' "s/{{work_type}}/$WORK_TYPE/g" "$FILEPATH"
  sed -i '' "s/{{description}}/$sub_desc/g" "$FILEPATH"
  sed -i '' "s/{{created}}/$CREATED/g" "$FILEPATH"
  
  # Add parent to related field
  sed -i '' "s/related: \[\]/related: [\"$PARENT\"]/g" "$FILEPATH"
  
  # Update parent's related field
  if ! grep -q "$SUB_ID" "$PARENT_FILE"; then
    # Get current related array
    CURRENT_RELATED=$(grep "^related:" "$PARENT_FILE" | sed 's/related: \[//;s/\]//')
    if [[ -z "$CURRENT_RELATED" || "$CURRENT_RELATED" == "" ]]; then
      NEW_RELATED="[\"$SUB_ID\"]"
    else
      NEW_RELATED="[$CURRENT_RELATED, \"$SUB_ID\"]"
    fi
    sed -i '' "s/related: \[.*\]/related: $NEW_RELATED/g" "$PARENT_FILE"
  fi
  
  echo "  Created: $FILENAME"
  return 0
}

# Create single or multiple sub-tasks
if [[ -n "$TITLE" ]]; then
  # Single sub-task
  echo "Creating sub-task for $PARENT:"
  create_subtask "$TITLE" "$DESCRIPTION" "$NEXT_NUM"
elif [[ -n "$TITLES" ]]; then
  # Multiple sub-tasks
  echo "Creating multiple sub-tasks for $PARENT:"
  
  # Parse titles and descriptions
  IFS=',' read -ra TITLE_ARRAY <<< "$TITLES"
  IFS=',' read -ra DESC_ARRAY <<< "$DESCRIPTIONS"
  
  for i in "${!TITLE_ARRAY[@]}"; do
    sub_title=$(echo "${TITLE_ARRAY[$i]}" | xargs)  # trim whitespace
    sub_desc=""
    if [[ $i -lt ${#DESC_ARRAY[@]} ]]; then
      sub_desc=$(echo "${DESC_ARRAY[$i]}" | xargs)
    fi
    create_subtask "$sub_title" "$sub_desc" "$NEXT_NUM"
    NEXT_NUM=$((NEXT_NUM + 1))
  done
else
  echo "Error: Either --title or --titles must be provided"
  exit 1
fi

echo ""
echo "✓ Sub-task creation complete!"
echo "Parent task updated: TaskNotes/Tasks/$(basename "$PARENT_FILE")"
