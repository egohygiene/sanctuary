# 🛠 TSCONFIG.md — TypeScript Config Reference

This document outlines the purpose of each `tsconfig.*.json` file in the project. These configurations are modular and layered to support different environments, workflows, and tooling.

---

## 🔧 `tsconfig.base.json`

> The root base config that all others extend. Contains strict flags, module settings, `paths`, and shared options across all targets.

```json
{
  "compilerOptions": {
    "target": "ESNext",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "strict": true,
    "baseUrl": ".",
    "paths": {
      "@egohygiene/*": ["src/*"]
    },
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "preserveSymlinks": true,
    "resolveJsonModule": true,
    "forceConsistentCasingInFileNames": true,
    "isolatedModules": true,
    "skipLibCheck": true,
    "noEmit": true
  }
}
```

---

## 🌐 `tsconfig.app.json`

> For the frontend app — React, Astro, or Vite-based UI projects.

```json
{
  "extends": "./tsconfig.base.json",
  "compilerOptions": {
    "jsx": "react-jsx",
    "jsxImportSource": "react",
    "types": ["vite/client", "astro/client"]
  },
  "include": ["src", "env.d.ts", ".astro/types.d.ts"]
}
```

---

## 🛠 `tsconfig.node.json`

> For server-side Node scripts, config files, CLI tools, or Astro/Vite configs.

```json
{
  "extends": "./tsconfig.base.json",
  "compilerOptions": {
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "types": ["node"],
    "outDir": "dist-node",
    "rootDir": ".",
    "composite": true
  },
  "include": ["plugins", "db", "astro.config.ts", "vite.config.ts"]
}
```

---

## ✅ `tsconfig.typecheck.json`

> Used to perform a complete typecheck pass across the entire project. No output.

```json
{
  "extends": "./tsconfig.app.json",
  "compilerOptions": {
    "noEmit": true
  },
  "include": ["src", "plugins", "db", "astro.config.ts", "vite.config.ts"]
}
```

---

## 🧹 `tsconfig.eslint.json`

> For ESLint’s type-aware rules (used by `@typescript-eslint/parser`).

```json
{
  "extends": "./tsconfig.base.json",
  "include": ["src", "plugins", "astro.config.ts"],
  "compilerOptions": {
    "types": ["vitest"]
  }
}
```

---

## 📦 `tsconfig.package.json`

> Used per-package in monorepos when publishing TypeScript packages.

```json
{
  "extends": "../../tsconfig.base.json",
  "compilerOptions": {
    "declaration": true,
    "emitDeclarationOnly": true,
    "composite": true,
    "outDir": "dist"
  },
  "include": ["src"]
}
```

---

## 📐 `tsconfig.build.json`

> Used for CI or prod builds with `.d.ts` only.

```json
{
  "extends": "./tsconfig.base.json",
  "compilerOptions": {
    "emitDeclarationOnly": true,
    "declaration": true,
    "outDir": "dist-types"
  },
  "include": ["src"]
}
```

---

## 🧪 `tsconfig.vitest.json`

> TypeScript setup for Vitest or other test runners.

```json
{
  "extends": "./tsconfig.base.json",
  "compilerOptions": {
    "types": ["vitest/globals"]
  },
  "include": ["src/**/*.test.ts", "tests"]
}
```

---

## 📖 `tsconfig.storybook.json`

> For Storybook + React setups.

```json
{
  "extends": "./tsconfig.base.json",
  "compilerOptions": {
    "types": ["storybook__react"],
    "jsx": "react-jsx"
  },
  "include": [".storybook", "src", "stories"]
}
```

---

## 📄 `tsconfig.docs.json`

> Used by Typedoc or Storybook to extract types for documentation.

```json
{
  "extends": "./tsconfig.base.json",
  "include": ["src"],
  "exclude": ["**/*.test.ts", "tests"]
}
```

---

## 🔬 `tsconfig.playground.json`

> Isolated sandbox for experimenting with types.

```json
{
  "extends": "./tsconfig.base.json",
  "include": ["playground"]
}
```

---

## 🧠 Tips

- All configs should extend `tsconfig.base.json` unless they're entry-point references.
- Use `tsconfig.json` at the root as your project reference aggregator:

```json
{
  "files": [],
  "references": [
    { "path": "./tsconfig.app.json" },
    { "path": "./tsconfig.node.json" },
    { "path": "./tsconfig.typecheck.json" }
  ]
}
```

---

