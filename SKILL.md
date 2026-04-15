---
name: claude-to-openclaw-converter
description: Convert Claude Code skills to OpenClaw AgentSkills format. Handles SKILL.md generation, script migration, resource organization, and automatic logging. Use when converting Claude skills, migrating skill libraries, or adapting community skills for OpenClaw.
metadata:
  openclaw:
    emoji: 🔄
    requires:
      bins: ["bash", "python3"]
---

# Claude → OpenClaw Skill Converter

Convert Claude Code skills to OpenClaw AgentSkills format with proper documentation and logging.

## Why This Exists

**Problem:** Skills get created but vanish - no record of what was built, where it went, or what changed.

**Solution:** Every conversion is logged. Every skill is documented. Nothing disappears.

---

## Conversion Process

### Step 1: Analyze Source Skill

```bash
bash ~/.../scripts/analyze-claude-skill.sh <claude-skill-path>
```

**Extracts:**
- Skill name and description
- Scripts (bash/python)
- Reference files
- Assets and templates
- Trigger patterns

### Step 2: Generate OpenClaw Structure

```
<skill-name>/
├── SKILL.md              # Generated with frontmatter + instructions
├── scripts/              # Migrated scripts (made executable)
├── references/           # Documentation files
└── assets/               # Templates, images, etc.
```

### Step 3: Create SKILL.md Frontmatter

```yaml
---
name: <skill-name>
description: <Clear description with triggers>
metadata:
  openclaw:
    emoji: <appropriate-emoji>
    requires:
      bins: [<required-binaries>]
---
```

### Step 4: Migrate Scripts

- Copy scripts to `scripts/`
- Make executable: `chmod +x scripts/*.sh`
- Update paths for OpenClaw workspace
- Test each script

### Step 5: Log the Conversion

**Automatic logging to:**
1. `memory/YYYY-MM-DD.md` - Daily session log
2. `CONVERSIONS.md` - Running conversion history
3. Skill's own `SKILL.md` - Embedded metadata

---

## Usage

### Convert a Single Skill

```bash
bash ~/.openclaw/workspace/skills/claude-to-openclaw-converter/scripts/convert-skill.sh \
  --source /path/to/claude/skill \
  --output ~/.openclaw/workspace/skills/ \
  --log
```

### Convert Multiple Skills

```bash
bash ~/.openclaw/workspace/skills/claude-to-openclaw-converter/scripts/batch-convert.sh \
  --source-dir ~/claude-skills/ \
  --output-dir ~/.openclaw/workspace/skills/ \
  --log
```

### Verify Conversion

```bash
bash ~/.openclaw/workspace/skills/claude-to-openclaw-converter/scripts/verify-skill.sh \
  --skill <skill-name>
```

---

## Logging System

**Every conversion creates 3 records:**

### 1. Daily Memory Log
`memory/YYYY-MM-DD.md` - What we did today

```markdown
## Skill Conversion: <skill-name>

**Source:** Claude Code skill from <path>
**Output:** `~/.openclaw/workspace/skills/<skill-name>/`
**Scripts migrated:** 3 (script1.sh, script2.py, script3.sh)
**References:** 2 (guide.md, api-ref.md)
**Status:** ✅ Complete, tested

**Files created:**
- SKILL.md (with frontmatter)
- scripts/script1.sh
- scripts/script2.py
- references/guide.md
```

### 2. Conversion History
`CONVERSIONS.md` - Running log of all conversions

```markdown
## 2026-04-06 - claude-skill-converter

**From:** ~/claude-skills/pdf-tools/
**To:** ~/.openclaw/workspace/skills/pdf-tools/
**Scripts:** 3
**Status:** ✅ Success
**Tested:** Yes
```

### 3. Skill Metadata
Embedded in `SKILL.md` frontmatter:

```yaml
metadata:
  converted:
    from: claude-code
    date: 2026-04-06
    source_path: ~/claude-skills/pdf-tools/
    converter_version: 1.0
```

---

## Claude vs OpenClaw Skill Differences

| Aspect | Claude Code | OpenClaw |
|--------|-------------|----------|
| **Manifest** | `CLAUDE.md` or `skills.json` | `SKILL.md` with YAML frontmatter |
| **Structure** | Flexible | `scripts/`, `references/`, `assets/` |
| **Triggers** | In config or inferred | In `description` field |
| **Scripts** | Any location | `scripts/` directory |
| **Logging** | Optional | Required (this skill enforces it) |

---

## Scripts Reference

| Script | Purpose |
|--------|---------|
| `convert-skill.sh` | Convert single skill |
| `batch-convert.sh` | Convert multiple skills |
| `analyze-claude-skill.sh` | Analyze source skill structure |
| `generate-skill-md.sh` | Generate SKILL.md from template |
| `verify-skill.sh` | Verify converted skill works |
| `log-conversion.sh` | Log conversion to memory + history |

---

## Templates

### SKILL.md Template

```markdown
---
name: {{skill_name}}
description: {{description}}
metadata:
  openclaw:
    emoji: {{emoji}}
    requires:
      bins: [{{bins}}]
  converted:
    from: claude-code
    date: {{date}}
    source_path: {{source}}
---

# {{Skill Name}}

{{Description of what the skill does}}

## Usage

{{How to use the skill}}

## Scripts

{{List of scripts and what they do}}

## References

{{List of reference files}}
```

---

## Best Practices

1. **Always log** - No conversion without logging
2. **Test scripts** - Run each script after migration
3. **Preserve structure** - Keep scripts/references/assets separate
4. **Clear triggers** - Description should explain when to use
5. **Backup source** - Keep original Claude skill until verified

---

## Troubleshooting

**Script paths broken:**
- Update hardcoded paths to use OpenClaw workspace
- Use `$HOME/.openclaw/workspace/` base

**Triggers not working:**
- Add more specific triggers to `description` field
- Include common phrases users would say

**Scripts fail:**
- Check permissions: `chmod +x scripts/*.sh`
- Verify dependencies are installed
- Test in isolation first

---

**Version:** 1.0  
**Created:** 2026-04-06  
**Purpose:** Stop losing work. Every conversion logged. Every skill documented.
