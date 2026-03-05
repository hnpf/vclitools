#!/bin/bash
# Virex CLI Tools: core shell functions

# Description: Go back (n) directories. Default is 1. No more "cd ../../../"
up() {
  local count=${1:-1}
  if [[ ! "$count" =~ ^[0-9]+$ ]]; then
    echo "Usage: up [number]"
    return 1
  fi
  local path=""
  for ((i=0; i<count; i++)); do
    path="../$path"
  done
  cd "$path" || return
}

# Description: create a directory and cd into it instantly.
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Description: smart jump, no args: lists all folders. with args: fuzzy-jumps to matching folder.
to() {
  local target="$1"
  local dirs=(*/)
  dirs=("${dirs[@]%/}") # Remove trailing slashes

  if [ -z "$target" ]; then
    if [ ${#dirs[@]} -eq 0 ]; then
      echo "No directories found."
      return
    fi
    for i in "${!dirs[@]}"; do
      printf "\e[34m%2d)\e[0m %s\n" "$((i+1))" "${dirs[$i]}"
    done
    read -p "Jump to: " choice
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#dirs[@]}" ]; then
      cd "${dirs[$((choice-1))]}"
    fi
    return
  fi

  local matches=()
  for d in "${dirs[@]}"; do
    if [[ "${d,,}" == "${target,,}"* ]]; then
      matches+=("$d")
    fi
  done

  if [ ${#matches[@]} -eq 1 ]; then
    cd "${matches[0]}"
  elif [ ${#matches[@]} -gt 1 ]; then
    for i in "${!matches[@]}"; do
      printf "\e[34m%2d)\e[0m %s\n" "$((i+1))" "${matches[$i]}"
    done
    read -p "Select: " choice
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#matches[@]}" ]; then
      cd "${matches[$((choice-1))]}"
    fi
  else
    echo "No directory matches '$target'."
  fi
}

# Description: smart open. matches file: opens in editor. matches folder: jumps inside.
o() {
  local target="$1"
  local pref_file="$HOME/.virex_editor"
  
  if [ ! -f "$pref_file" ]; then
    echo "First time using 'o'! Which editor do you prefer? (e.g., nano, vim, vi, code)"
    read -p "Editor: " chosen_editor
    echo "$chosen_editor" > "$pref_file"
  fi
  local editor=$(cat "$pref_file")

  if [ -z "$target" ]; then
    echo "Usage: o <pattern>"
    return
  fi

  # find both files and directories
  local matches=($(ls -d ${target}* 2>/dev/null))
  
  if [ ${#matches[@]} -eq 0 ]; then
    echo "No matches for '$target'."
    return
  elif [ ${#matches[@]} -eq 1 ]; then
    local selection="${matches[0]}"
    if [ -d "$selection" ]; then
      cd "$selection"
    else
      $editor "$selection"
    fi
  else
    for i in "${!matches[@]}"; do
      local type="F"
      [ -d "${matches[$i]}" ] && type="D"
      printf "\e[34m%2d)\e[0m [%s] %s\n" "$((i+1))" "$type" "${matches[$i]}"
    done
    read -p "Open: " choice
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#matches[@]}" ]; then
      local selection="${matches[$((choice-1))]}"
      if [ -d "$selection" ]; then
        cd "$selection"
      else
        $editor "$selection"
      fi
    fi
  fi
}

# Description: re-runs the last command with sudo.
please() {
  sudo $(fc -ln -1)
}

# export functions if needed, though sourcing handles it

# internal: check for fan cleaning reminder for dust module
if command -v dust >/dev/null 2>&1; then
  dust --check
fi
