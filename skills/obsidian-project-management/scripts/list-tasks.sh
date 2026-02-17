#!/bin/bash

# List tasks with optional filtering
# Usage: list-tasks.sh [--status=backlog] [--project=trading-signal-ai] [--component=ct100] [--priority=high] [--limit=50]

# Configuration
VAULT_PATH="/Users/sunginkim/Documents/Obsidian Vault"
TASKS_DIR="$VAULT_PATH/TaskNotes/Tasks"

# Filter parameters
FILTER_STATUS=""
FILTER_PROJECT=""
FILTER_COMPONENT=""
FILTER_PRIORITY=""
LIMIT=50

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --status=*)
      FILTER_STATUS="${1#*=}"
      shift
      ;;
    --project=*)
      FILTER_PROJECT="${1#*=}"
      shift
      ;;
    --component=*)
      FILTER_COMPONENT="${1#*=}"
      shift
      ;;
    --priority=*)
      FILTER_PRIORITY="${1#*=}"
      shift
      ;;
    --limit=*)
      LIMIT="${1#*=}"
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Check if tasks directory exists
if [[ ! -d "$TASKS_DIR" ]]; then
  echo "No tasks directory found at: $TASKS_DIR"
  echo "Run migration or create tasks first."
  exit 1
fi

# Build filter command
FILTER_CMD="grep -l 'tags:' $TASKS_DIR/*.md 2>/dev/null | head -$LIMIT"

# Apply filters
if [[ -n "$FILTER_STATUS" ]]; then
  FILTER_CMD="$FILTER_CMD | xargs grep -l \"status: $FILTER_STATUS\" 2>/dev/null"
fi

if [[ -n "$FILTER_PROJECT" ]]; then
  FILTER_CMD="$FILTER_CMD | xargs grep -l \"project: \\"$FILTER_PROJECT\\"\" 2>/dev/null"
fi

if [[ -n "$FILTER_COMPONENT" ]]; then
  FILTER_CMD="$FILTER_CMD | xargs grep -l \"component: $FILTER_COMPONENT\" 2>/dev/null"
fi

if [[ -n "$FILTER_PRIORITY" ]]; then
  FILTER_CMD="$FILTER_CMD | xargs grep -l \"priority: $FILTER_PRIORITY\" 2>/dev/null"
fi

# Execute filter and display results
echo "=== Task List ==="
echo ""

if [[ -n "$FILTER_STATUS" ]]; then
  echo "Status: $FILTER_STATUS"
fi
if [[ -n "$FILTER_PROJECT" ]]; then
  echo "Project: $FILTER_PROJECT"
fi
if [[ -n "$FILTER_COMPONENT" ]]; then
  echo "Component: $FILTER_COMPONENT"
fi
if [[ -n "$FILTER_PRIORITY" ]]; then
  echo "Priority: $FILTER_PRIORITY"
fi
echo "Limit: $LIMIT"
echo ""

# Get matching files
MATCHING_FILES=$(eval "$FILTER_CMD")

if [[ -z "$MATCHING_FILES" ]]; then
  echo "No tasks found matching criteria."
  exit 0
fi

# Display tasks in table format
printf "%-12s %-30s %-15s %-10s %-15s\n" "ID" "Title" "Status" "Priority" "Project"
printf "%-12s %-30s %-15s %-10s %-15s\n" "------------" "------------------------------" "---------------" "----------" "---------------"

for file in $MATCHING_FILES; do
  if [[ -f "$file" ]]; then
    # Extract fields from frontmatter
    TASK_ID=$(grep "^task-id:" "$file" | sed 's/task-id: "//;s/"$//' | xargs)
    TITLE=$(grep "^title:" "$file" | sed 's/title: "//;s/"$//' | xargs)
    STATUS=$(grep "^status:" "$file" | sed 's/status: //' | xargs)
    PRIORITY=$(grep "^priority:" "$file" | sed 's/priority: //' | xargs)
    PROJECT=$(grep "^project:" "$file" | sed 's/project: "//;s/"$//' | xargs)
    
    # Truncate title if too long
    if [[ ${#TITLE} -gt 28 ]]; then
      TITLE="${TITLE:0:25}..."
    fi
    
    printf "%-12s %-30s %-15s %-10s %-15s\n" "$TASK_ID" "$TITLE" "$STATUS" "$PRIORITY" "$PROJECT"
  fi
done

echo ""
echo "Total: $(echo "$MATCHING_FILES" | wc -l) tasks"
