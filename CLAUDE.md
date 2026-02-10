# Documentation Style Guide

## Writing Philosophy

**Be concise. No fluff.**

Write documentation that gets straight to the point. Users want information, not prose.

---

## Document Structure

### Minimal Introductions
- 1-2 sentences max for page intro
- Skip obvious context ("In this guide we will...")
- State what it is, move on

### Headings
- Use clear, direct headings
- H2 (`##`) for main sections
- H3 (`###`) for subsections
- Use `---` horizontal rules to separate major sections

### Content Organization
- **Tables** for specifications, comparisons, reference data
- **Step-by-step lists** for procedures (no paragraphs between steps)
- **Bullet points** for quick reference
- **Admonitions** (`!!! note`, `!!! warning`) for side notes only

---

## Writing Style

### Language Rules
- **Short sentences.** Period.
- **Imperative voice** for instructions: "Click the button" not "You should click the button"
- **No marketing language** - no "powerful", "seamless", "simply", etc.
- **No transitions** - skip "Now that...", "Next we will...", "Finally..."
- **Technical precision** over explanation

### Formatting
- Use **bold** for UI elements: **`button name`**, **`field name`**
- Use inline code for: commands, file paths, variable names
- Code blocks:
    - Always include `linenums="1"` for line numbers
    - Add `title="filename"` when the code is meant to be saved to a file
    - No title for commands being executed or output examples
- Screenshots for UI workflows (not text descriptions)

### What to Cut
- "This section will cover..."
- "As mentioned above..."
- "It's important to note that..."
- Verbose examples when one would do
- Background information unless critical
- Repetitive summaries

---

## Examples

### [BAD] Too Verbose
```markdown
## Introduction to User Management
In this section, we will walk through the process of adding
new users to the system. This is an important task that
administrators need to perform regularly. Follow these steps
carefully to ensure users are set up correctly.
```

### [GOOD] Correct
```markdown
## Adding new users
Login into [PLA](account.lab.wangup.org). Select the **`lam`**
server profile and login as admin.
```

---

## Technical Documentation

### Specifications
Use tables. No paragraphs.

```markdown
| Server | CPU | RAM |
|--------|-----|-----|
| Server 1 | Intel i7 | 126GB |
```

### Procedures
Direct steps. Use images.

```markdown
1. Click **`New user`** button
2. Fill in username in **`Last name`** field
3. Click **`Save`**
```

---

## MkDocs Specific

- Use admonitions sparingly: `!!! note`, `!!! warning`
- Include image paths: `![Description](filename.png)`
- Link format: `[text](url)` or `[text](../path/file.md)`

---

## Tone and Audience

- **Informative**, not instructional
- **Factual**, not persuasive
- **Practical**, not theoretical
- Audience may not be highly technical - provide enough detail for troubleshooting
- Include technical terms and specific names (services, commands, paths) so users can Google or ask LLMs for help when issues arise
- Balance brevity with completeness: short sentences, but sufficient context
