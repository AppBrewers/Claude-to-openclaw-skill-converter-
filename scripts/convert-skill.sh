#!/bin/bash
# Claude → OpenClaw Skill Converter
# Usage: bash convert-skill.sh --source <path> --output <dir> --log

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Defaults
SOURCE_DIR=""
OUTPUT_DIR="$HOME/.openclaw/workspace/skills/"
DO_LOG=true
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
TODAY=$(date +%Y-%m-%d)

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --source)
            SOURCE_DIR="$2"
            shift 2
            ;;
        --output)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        --no-log)
            DO_LOG=false
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

if [ -z "$SOURCE_DIR" ]; then
    echo "Usage: bash convert-skill.sh --source <claude-skill-path> [--output <dir>] [--no-log]"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}ERROR: Source directory not found: $SOURCE_DIR${NC}"
    exit 1
fi

SKILL_NAME=$(basename "$SOURCE_DIR")
DEST_DIR="$OUTPUT_DIR/$SKILL_NAME"

echo -e "${BLUE}🔄 Claude → OpenClaw Skill Converter${NC}"
echo "======================================"
echo "Source: $SOURCE_DIR"
echo "Destination: $DEST_DIR"
echo "Date: $TODAY"
echo ""

# Create destination
mkdir -p "$DEST_DIR"

# Step 1: Analyze source
echo -e "${YELLOW}Step 1: Analyzing source skill...${NC}"
SCRIPTS_COUNT=$(find "$SOURCE_DIR" -type f \( -name "*.sh" -o -name "*.py" \) 2>/dev/null | wc -l | tr -d ' ')
MD_COUNT=$(find "$SOURCE_DIR" -type f -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
echo "  Scripts found: $SCRIPTS_COUNT"
echo "  Markdown files: $MD_COUNT"

# Step 2: Create structure
echo -e "${YELLOW}Step 2: Creating OpenClaw structure...${NC}"
mkdir -p "$DEST_DIR/scripts"
mkdir -p "$DEST_DIR/references"
mkdir -p "$DEST_DIR/assets"

# Step 3: Copy scripts
echo -e "${YELLOW}Step 3: Migrating scripts...${NC}"
if [ $SCRIPTS_COUNT -gt 0 ]; then
    find "$SOURCE_DIR" -type f \( -name "*.sh" -o -name "*.py" \) -exec cp {} "$DEST_DIR/scripts/" \;
    chmod +x "$DEST_DIR/scripts/"*.sh 2>/dev/null || true
    echo -e "${GREEN}  ✅ Copied $SCRIPTS_COUNT scripts${NC}"
else
    echo "  ⚠️  No scripts found"
fi

# Step 4: Copy reference files
echo -e "${YELLOW}Step 4: Copying reference files...${NC}"
if [ $MD_COUNT -gt 0 ]; then
    find "$SOURCE_DIR" -type f -name "*.md" ! -name "CLAUDE.md" ! -name "README.md" -exec cp {} "$DEST_DIR/references/" \; 2>/dev/null || true
    echo -e "${GREEN}  ✅ Copied reference files${NC}"
else
    echo "  ⚠️  No reference files found"
fi

# Step 5: Copy assets (images, templates, etc.)
echo -e "${YELLOW}Step 5: Copying assets...${NC}"
find "$SOURCE_DIR" -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.template" -o -name "*.yaml" -o -name "*.yml" \) -exec cp {} "$DEST_DIR/assets/" \; 2>/dev/null || true
ASSET_COUNT=$(find "$DEST_DIR/assets" -type f 2>/dev/null | wc -l | tr -d ' ')
echo "  Assets copied: $ASSET_COUNT"

# Step 6: Generate SKILL.md
echo -e "${YELLOW}Step 6: Generating SKILL.md...${NC}"

# Try to extract name from source
if [ -f "$SOURCE_DIR/CLAUDE.md" ]; then
    SKILL_DESC=$(head -20 "$SOURCE_DIR/CLAUDE.md" | grep -v "^#" | head -3 | tr '\n' ' ' | cut -c1-200)
elif [ -f "$SOURCE_DIR/skills.json" ]; then
    SKILL_DESC=$(grep -o '"description"[[:space:]]*:[[:space:]]*"[^"]*"' "$SOURCE_DIR/skills.json" 2>/dev/null | head -1 | cut -d'"' -f4 || echo "Converted from Claude Code")
else
    SKILL_DESC="Converted from Claude Code skill"
fi

cat > "$DEST_DIR/SKILL.md" << EOF
---
name: $SKILL_NAME
description: $SKILL_DESC - Converted from Claude Code. Use when working with ${SKILL_NAME//-/ } tasks.
metadata:
  openclaw:
    emoji: 🔄
    requires:
      bins: ["bash"]
  converted:
    from: claude-code
    date: $TODAY
    source_path: $SOURCE_DIR
    converter_version: 1.0
---

# $SKILL_NAME

**Converted from Claude Code** on $TODAY

$SKILL_DESC

## Usage

{{Add usage instructions here}}

## Scripts

$(ls -1 "$DEST_DIR/scripts/" 2>/dev/null | sed 's/^/- /' || echo "- No scripts")

## References

$(ls -1 "$DEST_DIR/references/" 2>/dev/null | sed 's/^/- /' || echo "- No references")

## Conversion Notes

- Original source: $SOURCE_DIR
- Converted: $TODAY
- Scripts migrated: $SCRIPTS_COUNT
- Status: ✅ Complete (verify before use)

EOF

echo -e "${GREEN}  ✅ Generated SKILL.md${NC}"

# Step 7: Logging
if [ "$DO_LOG" = true ]; then
    echo -e "${YELLOW}Step 7: Logging conversion...${NC}"
    
    MEMORY_DIR="$HOME/.openclaw/workspace/memory"
    mkdir -p "$MEMORY_DIR"
    
    MEMORY_FILE="$MEMORY_DIR/$TODAY.md"
    CONVERSIONS_FILE="$HOME/.openclaw/workspace/CONVERSIONS.md"
    
    # Log to daily memory
    cat >> "$MEMORY_FILE" << EOF

## Skill Conversion: $SKILL_NAME

**Source:** $SOURCE_DIR
**Output:** \`$DEST_DIR/\`
**Scripts migrated:** $SCRIPTS_COUNT
**Status:** ✅ Complete

**Files created:**
- SKILL.md (with frontmatter + metadata)
- scripts/ ($(ls -1 "$DEST_DIR/scripts/" 2>/dev/null | tr '\n' ', ' || echo "none"))
- references/ ($(ls -1 "$DEST_DIR/references/" 2>/dev/null | tr '\n' ', ' || echo "none"))

EOF
    
    echo -e "${GREEN}  ✅ Logged to $MEMORY_FILE${NC}"
    
    # Log to conversions history
    if [ ! -f "$CONVERSIONS_FILE" ]; then
        cat > "$CONVERSIONS_FILE" << EOF
# Skill Conversion History

Track all Claude → OpenClaw skill conversions. Nothing gets lost.

---

EOF
    fi
    
    cat >> "$CONVERSIONS_FILE" << EOF
## $TODAY - $SKILL_NAME

**From:** $SOURCE_DIR
**To:** $DEST_DIR/
**Scripts:** $SCRIPTS_COUNT
**Status:** ✅ Success
**Tested:** Pending

EOF
    
    echo -e "${GREEN}  ✅ Logged to $CONVERSIONS_FILE${NC}"
fi

# Summary
echo ""
echo "======================================"
echo -e "${GREEN}✅ Conversion complete!${NC}"
echo ""
echo "Destination: $DEST_DIR"
echo ""
echo "Next steps:"
echo "1. Review and edit SKILL.md"
echo "2. Test scripts: bash $DEST_DIR/scripts/<script>.sh"
echo "3. Update description with proper triggers"
echo ""

exit 0
