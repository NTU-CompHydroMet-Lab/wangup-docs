# Documentation Style Guide

## Writing Philosophy

**Be concise. Explain the why. Cut everything else.**

A page earns its length by saving the reader a mistake or a search. A bare
command list is a recipe; the one sentence that says *why* a step exists is what
lets the reader troubleshoot when it breaks. Keep that sentence. Cut throat-clearing,
repetition, and context the reader already has.

Concise is not the same as terse. The goal is high information density — every
sentence carries weight — not the fewest possible words.

---

## Two Audiences

Write for whichever one owns the page. They need different densities.

- **User docs** (`getting-started/`, `user-guide/`, `hpc/`) — readers may not be
  deeply technical and have **no root**. Give the safe path plus enough *why* to
  self-diagnose. Never document a step that needs `sudo` as if the reader can run
  it — if it needs root, it belongs in a maintainer page or gets baked in at
  provisioning.
- **Maintainer docs** (`maintainer/`, `infrastructures/`) — readers have root and
  are changing infrastructure (often just future-you). Keep them as terse
  reminders, not tutorials. Mark a non-obvious decision in **one line** so no one
  "fixes" it back into a bug — don't argue the case. Internal IPs, hostnames, and
  those one-line markers live here, not in user pages. A reference page is not a
  runbook: it says what the thing is and the one command to do or check it, not
  every apply/rollback step.

---

## Document Structure

### Minimal Introductions
- 1-2 sentences max. State what the page is, move on.
- Skip obvious context ("In this guide we will...").

### Headings
- H2 (`##`) for main sections, H3 (`###`) for subsections.
- `---` horizontal rules between major sections.

### Content Organization
- **Tables** for specifications, comparisons, reference data.
- **Numbered steps** for procedures. No paragraphs between steps — put any needed
  reasoning in a single line under the step, or in an admonition.
- **Prose** for the *why*: mechanism, trade-off, or gotcha. One to three
  sentences, then stop.
- **Bullet lists** only for genuinely list-shaped content (options, items) — not
  as a way to avoid writing a sentence that needs to be a sentence.
- **Admonitions** (`!!! note`, `!!! warning`) for caveats and gotchas, sparingly.

---

## Writing Style

### Say why, not just what
The best pages in this repo explain the mechanism the moment it prevents a mistake:

> Podman is daemonless — containers run as child processes of your session. When
> you disconnect, they die.

That one sentence is why the page is useful. Include the *why* when it (a) prevents
a likely mistake, (b) helps the reader troubleshoot, or (c) records a non-obvious
decision. Cut it when it is background the reader already has.

Keep it to a sentence. The *why* is a pointer, not an essay — if the justification
runs longer than the instruction it explains, it doesn't belong inline. Mark a
non-obvious decision with a one-line landmine marker
(`# internal IP on purpose — DNS returns the slow public one`) and stop. A
reference page says what to do and what not to break; it is not where you defend
the decision against every alternative. That defense goes in the commit message or
an ADR.

### Define your jargon
The audience may not know `netns`, `SAN`, `bearer token`, `MTU`, `NFS`. On first
use in a page, define the term in half a sentence or link the
[glossary](docs/reference/glossary.md). Plain words first, the precise term in
parentheses: "the container has its own network namespace (`netns`)". A maintainer
explanation the next maintainer can't follow has failed, no matter how correct.

### Language Rules
- **Imperative voice** for instructions: "Click **`Save`**", not "You should click Save".
- Medium sentences are fine. Attach the *why* with an em-dash rather than dropping
  it — staccato one-word sentences read worse than a sentence that carries a reason.
- **No marketing language** — no "powerful", "seamless", "simply".
- **No filler transitions** — skip "Now that...", "Next we will...", "Finally...".

### Verification steps
When you document a "did it work?" check, give the **simplest** command that proves
it — one output field, not a diagnostic dump — plus the exact token that means
success, and name the false positive if there is one.

> Run `curl -sS -o /dev/null -w '%{remote_ip}' https://registry.lab.wangup.org/v2/`.
> Success is `192.168.250.62` (the internal address). Do **not** use `podman pull`
> timing as proof — a cached layer finishes in under a second having downloaded
> nothing.

### Formatting
- **Bold** for UI elements: **`button name`**, **`field name`**.
- Inline code for commands, file paths, variable names.
- Code blocks:
    - Always include `linenums="1"` for line numbers.
    - Add `title="filename"` when the code is meant to be saved to a file.
    - No title for commands being executed or output examples.
- Screenshots for UI workflows, not text descriptions.

### What to Cut
- "This section will cover...", "As mentioned above...", "It's important to note that...".
- A second example when one makes the point.
- Background that isn't load-bearing for the task.
- Repetitive summaries.

---

## Terminology Consistency

Pick one term per thing and use it everywhere. "internal IP" — not also "private
address" and "internal address". "lab registry", "NAS home", "local home". A thing
with three names breaks search and makes cross-links read like different topics.

---

## Examples

### Intro — [BAD] too verbose
```markdown
## Introduction to User Management
In this section, we will walk through the process of adding
new users to the system. This is an important task that
administrators need to perform regularly.
```

### Intro — [GOOD]
```markdown
## Adding new users
Login into [PLA](account.lab.wangup.org). Select the **`lam`**
server profile and login as admin.
```

### Step — [BAD] command with no why
```markdown
Add to `/etc/hosts`:
`192.168.250.62 registry.lab.wangup.org`
```

### Step — [GOOD] the same step, plus the line that matters
```markdown
Pin the registry to its internal address so image pulls take the 10 GbE path
instead of routing out to the public network (64x slower):

`192.168.250.62 registry.lab.wangup.org`

Verify the path with `curl -w '%{remote_ip}'` — you want `192.168.250.62`.
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
Direct numbered steps. Use images for UI.

```markdown
1. Click **`New user`** button
2. Fill in username in **`Last name`** field
3. Click **`Save`**
```

---

## MkDocs Specific

- Admonitions sparingly: `!!! note`, `!!! warning`.
- Image paths: `![Description](filename.png)`.
- Links: `[text](url)` or `[text](../path/file.md)`.

---

## Tone and Audience

- **Informative**, not instructional. **Factual**, not persuasive. **Practical**,
  not theoretical.
- Users may not be highly technical — provide enough detail, and enough *why*, to
  troubleshoot without you.
- Name the specific tool, command, path, or service so readers can Google or ask an
  LLM when stuck — but define it on first use (see [Define your jargon](#define-your-jargon)).
- Brevity through precision, not omission: short where a fact suffices, a full
  sentence where a reason is needed.
