#!/bin/bash

# Migrate TODOS.md to TaskNotes format
# Usage: migrate-todos.sh [--source=path] [--dry-run]

# Configuration
VAULT_PATH="/Users/sunginkim/Documents/Obsidian Vault"
DEFAULT_SOURCE="$VAULT_PATH/Trading-Signal-AI/TODOS.md"
SOURCE="$DEFAULT_SOURCE"
DRY_RUN=false

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --source=*)
      SOURCE="${1#*=}"
      shift
      ;;
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Check if source file exists
if [[ ! -f "$SOURCE" ]]; then
  echo "Error: Source file not found: $SOURCE"
  exit 1
fi

echo "=== TODOS.md Migration ==="
echo "Source: $SOURCE"
echo "Dry run: $DRY_RUN"
echo ""

# Create tasks directory
if [[ "$DRY_RUN" == false ]]; then
  mkdir -p "$VAULT_PATH/TaskNotes/Tasks"
  mkdir -p "$VAULT_PATH/TaskNotes/meta"
fi

# Define tasks to migrate from TODOS.md
declare -a TASKS=(
  "QuanLLM research"
  "Migrate other notes into here"
  "Use vectorBT to find most optimal capital allocation and leverage"
  "Create a same dev deployment structure on CT110 so we verify everything work end to end then deploy to CT100"
  "Fix ML flow"
  "Implement BTC Momentum Gate - Skip when btc_rsi_14 < 30"
  "Implement Vol Direction Gate - Skip when volatility_change <= 0"
  "Implement ADX Choppy Gate - Skip when adx_14 > 40"
)

declare -a PROJECTS=(
  "trading-signal-ai"
  "infrastructure"
  "trading-signal-ai"
  "infrastructure"
  "trading-signal-ai"
  "trading-signal-ai"
  "trading-signal-ai"
  "trading-signal-ai"
)

declare -a WORK_TYPES=(
  "research"
  "documentation"
  "research"
  "deployment"
  "model-training"
  "model-training"
  "model-training"
  "model-training"
)

declare -a COMPONENTS=(
  "none"
  "none"
  "none"
  "ct110"
  "none"
  "none"
  "none"
  "none"
)

declare -a PRIORITIES=(
  "medium"
  "low"
  "high"
  "high"
  "critical"
  "high"
  "high"
  "high"
)

# Get starting counter
if [[ -f "$VAULT_PATH/TaskNotes/meta/task-counter" ]]; then
  COUNTER=$(cat "$VAULT_PATH/TaskNotes/meta/task-counter")
else
  COUNTER=1
fi

echo "Found ${#TASKS[@]} TODOs to migrate"
echo "Starting from TASK-$(printf "%03d" "$COUNTER")"
echo ""

# Migrate each task
for i in "${!TASKS[@]}"; do
  TITLE="${TASKS[$i]}"
  PROJECT="${PROJECTS[$i]}"
  WORK_TYPE="${WORK_TYPES[$i]}"
  COMPONENT="${COMPONENTS[$i]}"
  PRIORITY="${PRIORITIES[$i]}"
  
  TASK_ID=$(printf "TASK-%03d" "$COUNTER")
  SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-' | cut -c1-40)
  FILENAME="${TASK_ID}-${SLUG}.md"
  
  echo "  $TASK_ID: $TITLE"
  
  if [[ "$DRY_RUN" == false ]]; then
    # Create task using create-task.sh
    ~/.config/opencode/skills/obsidian-project-management/scripts/create-task.sh \
      --title="$TITLE" \
      --project="$PROJECT" \
      --work-type="$WORK_TYPE" \
      --component="$COMPONENT" \
      --priority="$PRIORITY"
  fi
  
  COUNTER=$((COUNTER + 1))
done

echo ""

if [[ "$DRY_RUN" == true ]]; then
  echo "✓ Dry run complete. No files were created."
  echo "Run without --dry-run to actually migrate."
else
  echo "✓ Migration complete!"
  echo ""
  echo "Next steps:"
  echo "  1. Open Obsidian and refresh"
  echo "  2. Configure TaskNotes plugin settings"
  echo "  3. Open TaskNotes views to see your tasks"
  echo ""
  echo "Original TODOS.md preserved at: $SOURCE"
  echo "Consider archiving it after verifying migration."
fi
