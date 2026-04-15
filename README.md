# Claude → OpenClaw Skill Converter

Convert Claude Code skills to OpenClaw AgentSkills format.

## What It Does

- Analyzes Claude Code skill structure
- Generates OpenClaw SKILL.md with proper frontmatter
- Migrates scripts (bash/python) with executable permissions
- Organizes references and assets
- **Logs every conversion** (prevents lost work)

## Quick Start

```bash
# Convert a Claude skill
bash scripts/convert-claude-skill.sh /path/to/claude-skill /output/path

# Or use the wrapper
bash scripts/analyze-claude-skill.sh /path/to/claude-skill
```

## Installation

```bash
git clone https://github.com/AppBrewers/claude-to-openclaw-converter.git
claude-to-openclaw-converter/install.sh
```

## Why Use This?

**Problem:** Skills get created but vanish — no record of what was built.

**Solution:** Every conversion is logged. Every skill is documented.

## License

MIT
