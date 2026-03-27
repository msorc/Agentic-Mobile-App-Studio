#!/usr/bin/env bash
# Agentic Mobile App Studio — Status Line
# Receives JSON on stdin, outputs a single-line status.
#
# Segments: ctx% | model | production stage [| Feature > Task]

input=$(cat)

# --- Parse JSON (jq with grep fallback) ---
if command -v jq &>/dev/null; then
  model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')
  used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
  cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
else
  model=$(echo "$input" | grep -oE '"display_name"\s*:\s*"[^"]*"' | head -1 | sed 's/.*: *"//;s/"//')
  used_pct=$(echo "$input" | grep -oE '"used_percentage"\s*:\s*[0-9]+' | head -1 | sed 's/.*: *//')
  cwd=$(echo "$input" | grep -oE '"current_dir"\s*:\s*"[^"]*"' | head -1 | sed 's/.*: *"//;s/"//')
  [ -z "$model" ] && model="Unknown"
fi

# Normalize Windows paths
cwd=$(echo "$cwd" | sed 's|\\|/|g')
[ -z "$cwd" ] && cwd="."

# --- Context usage ---
if [ -n "$used_pct" ]; then
  ctx_label="ctx: ${used_pct}%"
else
  ctx_label="ctx: --"
fi

# --- Production stage ---
# Priority 1: Explicit stage from stage.txt
stage_file="$cwd/production/stage.txt"
stage=""
if [ -f "$stage_file" ]; then
  stage=$(head -1 "$stage_file" | tr -d '\r\n')
fi

# Priority 2: Auto-detect from artifacts
if [ -z "$stage" ]; then
  prd_file="$cwd/design/prd/"
  flutter_configured=false
  lib_count=0

  # Check if Flutter is configured (not placeholder)
  tech_prefs="$cwd/.claude/docs/technical-preferences.md"
  if [ -f "$tech_prefs" ]; then
    framework_line=$(grep -m1 '^\*\*Framework\*\*:' "$tech_prefs" 2>/dev/null || true)
    if [ -n "$framework_line" ] && ! echo "$framework_line" | grep -q "TO BE CONFIGURED"; then
      flutter_configured=true
    fi
  fi

  # Count Dart files in lib/
  if [ -d "$cwd/lib" ]; then
    lib_count=$(find "$cwd/lib" -type f -name "*.dart" 2>/dev/null | wc -l | tr -d ' ')
  fi

  # Count design docs
  has_prd=false
  [ -d "$prd_file" ] && [ "$(ls -A "$prd_file" 2>/dev/null)" ] && has_prd=true

  # Determine stage (check from most-advanced backward)
  if [ "$lib_count" -ge 20 ] 2>/dev/null; then
    stage="Production"
  elif [ "$flutter_configured" = true ]; then
    stage="Pre-Production"
  elif [ "$has_prd" = true ]; then
    stage="Planning"
  else
    stage="Concept"
  fi
fi

# --- Feature/Task breadcrumb (Production+ only) ---
breadcrumb=""
if [ "$stage" = "Production" ] || [ "$stage" = "Polish" ] || [ "$stage" = "Release" ]; then
  state_file="$cwd/production/session-state/active.md"
  if [ -f "$state_file" ]; then
    # Parse structured STATUS block
    in_block=false
    feature="" task=""
    while IFS= read -r line; do
      case "$line" in
        *"<!-- STATUS -->"*) in_block=true; continue ;;
        *"<!-- /STATUS -->"*) break ;;
      esac
      if [ "$in_block" = true ]; then
        case "$line" in
          Feature:*) feature=$(echo "$line" | sed 's/^Feature: *//') ;;
          Task:*) task=$(echo "$line" | sed 's/^Task: *//') ;;
        esac
      fi
    done < "$state_file"

    # Build breadcrumb from whatever is set
    parts=""
    [ -n "$feature" ] && parts="$feature"
    [ -n "$task" ] && parts="${parts:+$parts > }$task"
    [ -n "$parts" ] && breadcrumb=" | $parts"
  fi
fi

# --- Assemble ---
printf "%s" "${ctx_label} | ${model} | ${stage}${breadcrumb}"
