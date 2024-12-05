#!/bin/bash

# Script to replace Continue branding with Daemonium-Core
# Handles multiple text cases while preserving functionality

# Function to escape string for sed
escape_for_sed() {
    echo "$1" | sed 's/[\/&]/\\&/g'
}

# Define replacement pairs (old->new)
declare -A replacements=(
    ["continue"]="daemonium-core"
    ["Continue"]="Daemonium-Core"
    ["CONTINUE"]="DAEMONIUM_CORE"
    ["continuedev"]="unitylabai"
    ["ContinueDev"]="UnityLabAI"
    ["continue.dev"]="unitylabai.com"
    ["Continue.dev"]="UnityLabAI.com"
    ["CONTINUE.DEV"]="UNITYLABAI.COM"
    ["Continue Dev"]="Unity Lab AI"
    ["ContinueAI"]="UnityLabAI"
    ["Continue AI"]="Unity Lab AI"
    ["Continue's"]="Daemonium-Core's"
)

# File extensions to process
EXTENSIONS="\.(js|jsx|ts|tsx|py|java|kt|rs|json|md|mdx|txt|html|xml|yaml|yml|sh|properties|plist|rc)$"

# Find all matching files, excluding specified directories
find . -type f \
    -not -path "*/node_modules/*" \
    -not -path "*/.git/*" \
    -not -path "*/dist/*" \
    -not -path "*/out/*" \
    -not -path "*/build/*" \
    -regex ".*${EXTENSIONS}" \
    -print0 | while IFS= read -r -d '' file; do

    # Skip binary files
    if file "$file" | grep -q "binary"; then
        continue
    fi

    # Create sed script for all replacements
    sed_script=""
    for old in "${!replacements[@]}"; do
        new="${replacements[$old]}"
        old_escaped=$(escape_for_sed "$old")
        new_escaped=$(escape_for_sed "$new")

        # Handle different case formats
        # Original case
        sed_script="$sed_script;s/$old_escaped/$new_escaped/g"
        # Camel case
        sed_script="$sed_script;s/$(echo $old_escaped | sed 's/-\([a-z]\)/\u\1/g')/$(echo $new_escaped | sed 's/-\([a-z]\)/\u\1/g')/g"
        # Pascal case
        sed_script="$sed_script;s/$(echo $old_escaped | sed 's/\b\w/\u&/g' | sed 's/-//g')/$(echo $new_escaped | sed 's/\b\w/\u&/g' | sed 's/-//g')/g"
        # Snake case
        sed_script="$sed_script;s/$(echo $old_escaped | sed 's/-/_/g')/$(echo $new_escaped | sed 's/-/_/g')/g"
        # Kebab case
        sed_script="$sed_script;s/$(echo $old_escaped | tr '[:upper:]' '[:lower:]' | sed 's/_/-/g')/$(echo $new_escaped | tr '[:upper:]' '[:lower:]' | sed 's/_/-/g')/g"
    done

    # Remove leading semicolon
    sed_script="${sed_script#;}"

    # Apply replacements
    if [[ -n "$sed_script" ]]; then
        sed -i "$sed_script" "$file"
    fi
done

echo "Rebranding complete. Please review changes before committing."
