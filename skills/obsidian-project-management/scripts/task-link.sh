#!/bin/bash

# Link existing tasks without creating new ones
# Usage: task-link.sh --task=TASK-001 [--related="TASK-002,TASK-003"] [--blockedBy="TASK-004"]

# Configuration
VAULT_PATH="/Users/sunginkim/Documents/Obsidian Vault"
TASKS_DIR="$VAULT_PATH/TaskNotes/Tasks"

# Parameters
TASK_ID=""
RELATED=""
BLOCKED_BY=""
PROJECTS=""

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --task=*)
      TASK_ID="${1#*=}"
      shift
      ;;
    --related=*)
      RELATED="${1#*=}"
      shift
      ;;
    --blockedBy=*)
      BLOCKED_BY="${1#*=}"
      shift
      ;;
    --projects=*)
      PROJECTS="${1#*=}"
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Validate task ID
if [[ -z "$TASK_ID" ]]; then
  echo "Error: --task is required"
  exit 1
fi

# Find task file
TASK_FILE=$(find "$TASKS_DIR" -name "${TASK_ID}-*.md" -type f 2>/dev/null | head -1)
if [[ -z "$TASK_FILE" ]]; then
  echo "Error: Task not found: $TASK_ID"
  exit 1
fi

echo "Linking task: $TASK_ID"

# Update related field
if [[ -n "$RELATED" ]]; then
  # Parse related tasks
  RELATED_CLEAN=$(echo "$RELATED" | tr -d '[]"' | tr ',' '\n' | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//' | awk '{printf "\"%s\",", $0}' | sed 's/,$//')
  
  # Check if related field exists
  if grep -q "^related:" "$TASK_FILE"; then
    # Get existing related tasks
    EXISTING=$(grep "^related:" "$TASK_FILE" | sed 's/related: \[//;s/\]//')
    if [[ -n "$EXISTING" && "$EXISTING" != "" ]]; then
      # Merge existing with new
      NEW_RELATED="[$EXISTING, $RELATED_CLEAN]"
    else
      NEW_RELATED="[$RELATED_CLEAN]"
    fi
    sed -i '' "s/^related: \[.*\]/related: $NEW_RELATED/g" "$TASK_FILE"
  else
    # Add new related field
    sed -i '' "/^---/,/^---/{ /^---$/a\\
related: [$RELATED_CLEAN]
}" "$TASK_FILE"
  fi
  echo "  ✓ Updated related: [$RELATED_CLEAN]"
fi

# Update blockedBy field
if [[ -n "$BLOCKED_BY" ]]; then
  # Parse blockedBy tasks
  BLOCKED_CLEAN=$(echo "$BLOCKED_BY" | tr -d '[]"' | tr ',' '\n' | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//' | awk '{printf "\"%s\",", $0}' | sed 's/,$//')
  
  # Check if blockedBy field exists
  if grep -q "^blockedBy:" "$TASK_FILE"; then
    # Get existing blockedBy tasks
    EXISTING=$(grep "^blockedBy:" "$TASK_FILE" | sed 's/blockedBy: \[//;s/\]//')
    if [[ -n "$EXISTING" && "$EXISTING" != "" ]]; then
      # Merge existing with new
      NEW_BLOCKED="[$EXISTING, $BLOCKED_CLEAN]"
    else
      NEW_BLOCKED="[$BLOCKED_CLEAN]"
    fi
    sed -i '' "s/^blockedBy: \[.*\]/blockedBy: $NEW_BLOCKED/g" "$TASK_FILE"
  else
    # Add new blockedBy field after related or at end of frontmatter
    if grep -q "^related:" "$TASK_FILE"; then
      sed -i '' "/^related:/a\\
blockedBy: [$BLOCKED_CLEAN]" "$TASK_FILE"
    else
      sed -i '' "/^---/,/^---/{ /^---$/a\\
blockedBy: [$BLOCKED_CLEAN]
}" "$TASK_FILE"
    fi
  fi
  echo "  ✓ Updated blockedBy: [$BLOCKED_CLEAN]"
fi

# Update projects field
if [[ -n "$PROJECTS" ]]; then
  # Parse project links
  PROJECTS_CLEAN=$(echo "$PROJECTS" | tr -d '[]' | tr ',' '\n' | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//' | awk '{printf "\"%s\",", $0}' | sed 's/,$//')
  
  # Check if projects field exists
  if grep -q "^projects:" "$TASK_FILE"; then
    # Get existing projects
    EXISTING=$(grep "^projects:" "$TASK_FILE" | sed 's/projects: \[//;s/\]//')
    if [[ -n "$EXISTING" && "$EXISTING" != "" ]]; then
      # Merge existing with new
      NEW_PROJECTS="[$EXISTING, $PROJECTS_CLEAN]"
    else
      NEW_PROJECTS="[$PROJECTS_CLEAN]"
    fi
    sed -i '' "s/^projects: \[.*\]/projects: $NEW_PROJECTS/g" "$TASK_FILE"
  else
    # Add new projects field
    sed -i '' "/^---/,/^---/{ /^---$/a\\
projects: [$PROJECTS_CLEAN]
}" "$TASK_FILE"
  fi
  echo "  ✓ Updated projects: [$PROJECTS_CLEAN]"
fi

echo ""
echo "✓ Task linking complete: $TASK_ID"
