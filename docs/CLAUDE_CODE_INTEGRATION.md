# Claude Code Playbook Integration

This project can be enhanced with AI-assisted development using the Claude Code Playbook.

## Quick Start

1. **Clone the Claude Code Playbook:**
   ```bash
   git clone https://github.com/dyb5784/claude-code-playbook.git
   ```

2. **Copy templates to your project:**
   ```bash
   cp claude-code-playbook/templates/CLAUDE.md.template ./CLAUDE.md
   cp claude-code-playbook/templates/.cursorrules.template ./.cursorrules
   ```

3. **Customize the templates** for your project needs

4. **Start using Claude Code** with your project!

## Available Skills

### Python Scientific Computing
For simulation development, numerical analysis, and statistical validation:
```bash
view skills/python-scientific/SKILL.md
```

### General Refactoring
For code improvement and architecture:
```bash
claude skills refactoring <workflow-name>
```

## Workflow Examples

### Start a Session
```bash
/clear
claude skills refactoring qnew
```

### Analyze Codebase
```bash
claude skills refactoring triage
```

### Extract Function
```bash
claude skills refactoring extract
```

### Modernize Patterns
```bash
claude skills refactoring modernize
```

## Session Management

**Every 5-7 prompts, reset:**
```bash
/cost                              # Check token usage
/clear                             # Reset context
claude skills refactoring catchup  # Restore context
```

## Documentation

- [Claude Code Playbook Repository](https://github.com/dyb5784/claude-code-playbook)
- [Getting Started Guide](https://github.com/dyb5784/claude-code-playbook/blob/main/docs/GETTING_STARTED.md)
- [Workflow Guide](https://github.com/dyb5784/claude-code-playbook/blob/main/docs/WORKFLOW_GUIDE.md)

## Version History

**ACP Simulation v4.0.0** - Claude Code components separated into independent playbook