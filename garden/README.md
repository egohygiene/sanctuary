# Garden

The `garden/` directory is a fully configured Obsidian vault — the canonical
knowledge management foundation for the Ego Hygiene ecosystem.

It is designed to serve as a **Mind Garden**: a living, connected system for
capturing ideas, building knowledge, managing projects, and publishing insights.

## Quick Start

1. Open Obsidian and select **Open folder as vault**
2. Choose this `garden/` directory
3. Accept the prompt to install community plugins
4. Install the **Minimal** theme via `Settings → Appearance → Themes → Browse`
5. The vault opens to `dashboards/Home` automatically

## Vault Structure

```
garden/
├── .obsidian/          # Obsidian configuration (plugins, hotkeys, workspace)
├── assets/
│   ├── attachments/    # Images and file attachments
│   └── excalidraw/     # Excalidraw drawings
├── awesome/            # Curated resource lists by topic
├── concepts/           # Atomic concept notes
├── content/            # Draft content for publishing
├── dashboards/         # Dataview-powered navigation dashboards
│   ├── Home.md         # Main home dashboard (default on startup)
│   ├── Capture.md      # Inbox and processing dashboard
│   └── Current Focus.md # Active projects and priorities
├── experiments/        # Exploratory notes and experiments
├── health/             # Health and wellbeing tracking
├── journal/
│   ├── daily/          # Daily notes (YYYY-MM-DD.md)
│   ├── weekly/         # Weekly reviews (YYYY-[W]WW.md)
│   └── monthly/        # Monthly reviews (YYYY-MM.md)
├── maps/               # Maps of Content (MOCs) — navigation indexes
│   ├── Health.md
│   ├── Projects.md
│   └── Research.md
├── notes/              # General and fleeting notes
├── projects/           # Project notes
├── publish/            # Notes flagged for external publishing
├── quartz/             # Quartz digital garden integration
├── reflections/        # Personal reflections
├── research/
│   └── references/     # Literature notes from citations plugin
├── templates/          # Templater note templates
└── README.md
```

## Community Plugins

The vault includes a curated set of 17 community plugins.
See [`.obsidian/README.md`](.obsidian/README.md) for the full rationale.

| Plugin | Purpose |
| ------ | ------- |
| Dataview | Query-based dashboards and note databases |
| Templater | Dynamic note templates |
| Calendar | Calendar sidebar widget |
| Periodic Notes | Daily / weekly / monthly notes |
| Tasks | Task management with due dates and recurrence |
| Obsidian Git | Automatic vault backup and sync |
| Omnisearch | Improved full-text search |
| Advanced Tables | Markdown table editing |
| Excalidraw | Visual diagrams and drawings |
| Mind Map | Render notes as mind maps |
| Citations | Zotero / BibTeX bibliography integration |
| Longform | Long-form writing project management |
| Homepage | Open Home dashboard on startup |
| Style Settings | Theme customization |
| Kanban | Visual Kanban boards |
| Charts | Chart.js data visualization |
| Commander | Custom ribbon and UI buttons |

## Templates

Templates are stored in `templates/` and use **Templater** syntax.

| Template | Purpose |
| -------- | ------- |
| `daily-note.md` | Morning intentions, tasks, evening reflection |
| `weekly-review.md` | Weekly wins, learnings, next week priorities |
| `monthly-review.md` | Monthly retrospective and goal setting |
| `project.md` | Project note with tasks, log, and decisions |
| `concept.md` | Atomic concept definition |
| `research.md` | Research question, findings, sources |
| `meeting.md` | Meeting agenda, notes, action items |
| `book.md` | Book notes, highlights, key ideas |
| `resource.md` | External resource capture |
| `map-of-content.md` | MOC index template |
| `journal-entry.md` | Freeform journal entry |
| `default.md` | Blank note with front-matter |

## Keyboard Shortcuts

| Hotkey | Action |
| ------ | ------ |
| `Alt+D` | Open today's daily note |
| `Alt+W` | Open this week's note |
| `Alt+E` | Insert Templater template |
| `Alt+N` | Create new note from template |
| `Alt+X` | Create new Excalidraw drawing |
| `Alt+K` | Create new Kanban board |
| `Alt+M` | Open note as mind map |
| `Cmd+F` | Omnisearch in-file |
| `Cmd+Shift+F` | Omnisearch vault-wide |

## Architecture Decisions

- **Periodic Notes over core Daily Notes** — more flexible folder structure
  and weekly/monthly note support.
- **Templater over core Templates** — dynamic dates, cursor placement,
  and scripting capability.
- **Dataview** is the foundation for all dashboards; it transforms the vault
  from a collection of files into a queryable knowledge base.
- **Minimal theme** is recommended for its clean aesthetics and deep
  Style Settings integration.
- **Git sync** is configured at 10-minute intervals to ensure vault changes
  are committed automatically without manual intervention.
- **Excalidraw SVG export** is enabled so drawings remain readable outside
  Obsidian (e.g. in GitHub, docs site).
- **Citations** references are stored in `research/references/` using a
  structured template to integrate with the Research MOC.

## Related

- [Architecture Audit](../docs/architecture/audit.md)
- [Responsibility Matrix](../docs/architecture/responsibility-matrix.md)
- [Quartz Integration](quartz/README.md)
