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

## Notes

Templates are expected to evolve over time.

As patterns stabilize, common functionality may be extracted into shared templates, reusable components, or dedicated repositories.
