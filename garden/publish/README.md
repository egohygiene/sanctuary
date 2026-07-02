# Publish

Notes placed in this directory are included in the published digital garden.

This folder is the **content source** for the Quartz publishing pipeline.
Only files committed here are rendered on the public site — the rest of the
vault remains private.

## How to publish a note

1. Write or finalize the note anywhere in the vault.
2. Move or copy it into this `publish/` directory.
3. Optionally add front-matter to control how the note appears on the site:

```yaml
---
title: My Note Title
description: A short description shown in search results and link previews.
tags:
  - concept
  - example
aliases:
  - An Alternative Title
date: 2026-01-01
---
```

4. Commit and push. The [`garden.yml`](../../.github/workflows/garden.yml)
   workflow will build and publish the updated site automatically.

## Front-matter reference

| Property | Purpose |
|----------|---------|
| `title` | Override the displayed page title (defaults to the filename). |
| `description` | Short summary for search results and Open Graph previews. |
| `tags` | Categorisation tags rendered on the site. |
| `aliases` | Alternative names used for link resolution. |
| `date` | Publication or creation date (`YYYY-MM-DD`). |
| `draft: true` | Exclude the note from the published build. |
| `publish: false` | Exclude the note when the `explicit-publish` plugin is enabled. |

## Folder structure

Sub-folders are supported. Quartz preserves the directory hierarchy and
generates folder index pages automatically.

```
publish/
├── concepts/        # Atomic concept notes
├── maps/            # Maps of Content (MOCs)
├── notes/           # General notes
└── README.md        # This file (excluded from the published site)
```

## Related

- [Quartz integration](../quartz/README.md)
- [Garden README](../README.md)
