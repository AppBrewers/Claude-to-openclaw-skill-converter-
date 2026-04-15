# Claude → OpenClaw Skill Converter

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Works with OpenClaw](https://img.shields.io/badge/Works%20with-OpenClaw-blue.svg)](https://openclaw.ai)
[![Built for OpenClaw](https://img.shields.io/badge/Built%20for-OpenClaw-6B4C9A.svg)](https://openclaw.ai)
[![OpenClaw Compatible](https://img.shields.io/badge/OpenClaw-Compatible-success.svg)](https://openclaw.ai)
[![Claude Code](https://img.shields.io/badge/Works%20with-Claude%20Code-green.svg)](https://claude.ai/code)

> **The official bridge from Claude Code to OpenClaw.** Convert your skills and never lose work again.

**✅ Works with OpenClaw** — Native AgentSkill format output  
**✅ Built for OpenClaw** — Follows OpenClaw best practices  
**✅ OpenClaw Compatible** — Ready for ClawHub publishing  

---

## 🎯 What It Does (Works with OpenClaw)

```
Claude Skill (your-project/skill/)
    ↓
[Analyze Structure]
    ↓
OpenClaw AgentSkill (workspace/skills/your-skill/)
    ├── SKILL.md (with frontmatter)
    ├── scripts/ (migrated + executable)
    ├── references/ (docs, links)
    └── assets/ (templates, images)
```

**Every conversion is logged.** No skill ever disappears.

---

## 🚀 Quick Start (Get Started with OpenClaw)

### One-Line Install

```bash
git clone https://github.com/AppBrewers/claude-to-openclaw-skill-converter.git
bash claude-to-openclaw-converter/install.sh
```

### Convert Your First Skill for OpenClaw

```bash
# Convert a Claude skill to OpenClaw format
bash claude-to-openclaw-converter/scripts/convert-claude-skill.sh \
  /path/to/your/claude-skill \
  /path/to/openclaw/workspace/skills/
```

**Done.** Your skill is now in OpenClaw format and ready to use!
- ✅ Proper SKILL.md frontmatter
- ✅ Executable scripts
- ✅ Organized references
- ✅ Conversion logged

---

## 📊 Before vs After

| Feature | Claude Code | OpenClaw (via Converter) |
|---------|-------------|--------------------------|
| **Structure** | Flat files | Organized (scripts/, references/) |
| **Documentation** | Markdown only | SKILL.md with metadata |
| **Logging** | ❌ None | ✅ Every conversion logged |
| **Reusability** | Project-specific | Portable AgentSkill |
| **Sharing** | Manual copy | ClawHub ready |

---

## 💡 Why Use This?

### The Problem
You spent 3 hours building a Claude skill. It works perfectly. Three months later:
- ❌ Where did you save it?
- ❌ What was the structure?
- ❌ Did you document it?
- ❌ **It's gone.**

### The Solution
This converter ensures:
- ✅ **Structure preserved** — Claude → OpenClaw format
- ✅ **Documentation generated** — SKILL.md with frontmatter
- ✅ **Every conversion logged** — `conversion-2024-01-15.log`
- ✅ **Never lose work again**

---

## 🔧 How It Works

### Step 1: Analyze
Reads your Claude skill structure:
```
your-claude-skill/
├── skill.yaml
├── commands/
│   └── my-command.sh
└── README.md
```

### Step 2: Transform
Creates OpenClaw AgentSkill:
```
your-openclaw-skill/
├── SKILL.md              # Generated with metadata
├── scripts/
│   └── my-command.sh     # Made executable
├── references/
│   └── README.md         # Original docs
└── .conversions/
    └── 2024-01-15.log    # Conversion logged
```

### Step 3: Log
Every conversion saved:
```log
[2024-01-15 14:30:05] Converted: my-claude-skill
  → Output: /workspace/skills/my-openclaw-skill
  → Scripts: 3 migrated
  → References: 2 copied
  → Status: SUCCESS
```

---

## 🎯 Use Cases

### 1. Claude Code → OpenClaw Migration
Moving from Claude Code to OpenClaw? Convert all your skills at once.

### 2. Skill Backup
Create OpenClaw versions of your Claude skills as **backups**.

### 3. Skill Sharing
Convert to OpenClaw format → Publish on [ClawHub](https://clawhub.ai).

### 4. Skill Audit
Log every skill you've built. Never lose institutional knowledge.

---

## 📚 Example: Convert a Skill

### Input: Claude Code Skill
```bash
/path/to/claude-skills/
└── weather-check/
    ├── skill.yaml
    └── get-weather.sh
```

### Run Converter
```bash
bash scripts/convert-claude-skill.sh \
  /path/to/claude-skills/weather-check \
  /Users/you/openclaw/skills/
```

### Output: OpenClaw AgentSkill
```bash
/Users/you/openclaw/skills/weather-check/
├── SKILL.md                  # Generated
├── scripts/
│   └── get-weather.sh        # Executable ✓
├── references/
│   └── ORIGINAL-README.md    # Preserved
└── .conversions/
    └── 2024-01-15-143005.log # Logged ✓
```

---

## 🔗 Related Projects

- [OpenClaw](https://openclaw.ai) — The platform this converts skills for
- [ClawHub](https://clawhub.ai) — Share your converted skills
- [Claude Code](https://claude.ai/code) — Where skills come from

---

## 🤝 Contributing

Found a skill that doesn't convert perfectly? [Open an issue](https://github.com/AppBrewers/claude-to-openclaw-converter-/issues).

Want to add support for more Claude features? [Submit a PR](https://github.com/AppBrewers/claude-to-openclaw-converter-/pulls).

---

## 📄 License

MIT © [AppBrewers](https://github.com/AppBrewers)

---

## 💬 Questions?

- **Discord:** [OpenClaw Community](https://discord.gg/openclaw)
- **Twitter:** [@OpenClawHQ](https://twitter.com/OpenClawHQ)
- **Issues:** [GitHub Issues](https://github.com/AppBrewers/claude-to-openclaw-converter-/issues)

---

> **Built by people who lost too many skills.**
