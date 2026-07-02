# Application Templates

This directory contains reusable application templates used throughout the Sanctuary ecosystem.

The goal of these templates is to provide opinionated, production-ready starting points that can be copied, adapted, and evolved into standalone projects.

## Philosophy

Templates should prioritize:

* Developer experience (DX)
* Reproducibility
* Documentation
* Automation
* Testing
* Maintainability

Templates are intended to capture proven patterns rather than experimental ideas.

Experimental work should remain in the repository until it stabilizes.

## Structure

Each application template should be self-contained and include the files required to bootstrap a new project.

Example:

```text
react-vite/
├── .github/
├── docs/
├── public/
├── src/
├── package.json
├── vite.config.ts
└── README.md
```

## Current Templates

| Template   | Description                                     |
| ---------- | ----------------------------------------------- |
| react-vite | React + TypeScript + Vite application template. |

## Future Templates

Potential future templates include:

* React + Electron
* React + Tauri
* Flutter
* FastAPI
* Flask
* Full-stack application templates
* AI application templates

## AI Discoverability

Each application template includes a `public/llms.txt` file following the [llms.txt specification](https://llmstxt.org/).

This file is served from the application root and provides structured metadata that enables AI assistants, language models, and indexing systems to discover high-value project documentation and understand the repository structure.

### Customizing `llms.txt`

After generating a new project from a template, update `public/llms.txt` to reflect your project:

1. Replace `[Project Name]` with the actual project name.
2. Replace the blockquote summary with a concise description of your project.
3. Replace the introductory paragraph with relevant background context.
4. Update each section to point to your real documentation files.
5. Remove any sections or links that do not apply to your project.
6. Add new sections as needed for your specific use case.

Sections marked `## Optional` contain lower-priority links that AI systems may omit when operating under context constraints.

### Structure

The `llms.txt` file follows this format:

```text
# Project Name

> Short summary of the project.

Additional context paragraphs.

## Documentation

- [File Name](relative/path.md): Brief description

## Optional

- [Secondary File](relative/path.md): Description
```

## Notes

Templates are expected to evolve over time.

As patterns stabilize, common functionality may be extracted into shared templates, reusable components, or dedicated repositories.
