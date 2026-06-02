import js from "@eslint/js";
import typescriptEslintPlugin from "@typescript-eslint/eslint-plugin";
import typescriptParser from "@typescript-eslint/parser";
import reactPlugin from "eslint-plugin-react";
import { defineConfig, globalIgnores } from "eslint/config";
import globals from "globals";

export default defineConfig([
    globalIgnores(
        [
            "**/node_modules/**",
            "**/.pnpm/**",
            "**/.yarn/**",

            "**/dist/**",
            "**/build/**",
            "**/coverage/**",

            "**/.cache/**",
            "**/.nyc_output/**",
            "**/.vitest/**",
            "**/.eslintcache",

            "**/*.min.js",
            "**/*.tsbuildinfo",

            "**/cypress/videos/**",
            "**/cypress/screenshots/**",

            "**/*.log",

            "**/.vscode/**",
            "**/*.swp",
            "**/*.swo",

            "**/.husky/**",
            "**/.devcontainer/target/**",
        ],
        "Ignore dependencies, generated artifacts, caches, and local tooling state",
    ),

    js.configs.recommended,

    {
        files: ["**/*.{js,mjs,cjs}"],

        languageOptions: {
            ecmaVersion: "latest",
            sourceType: "module",
            globals: {
                ...globals.browser,
                ...globals.node,
                ...globals.es2024,
            },
        },
    },

    {
        files: ["**/*.{ts,tsx}"],

        languageOptions: {
            parser: typescriptParser,
            parserOptions: {
                ecmaVersion: "latest",
                sourceType: "module",
                project: "./tsconfig.eslint.json",
                tsconfigRootDir: import.meta.dirname,
                ecmaFeatures: {
                    jsx: true,
                },
            },
            globals: {
                ...globals.browser,
                ...globals.node,
                ...globals.es2024,
                ...globals.vitest,
            },
        },

        plugins: {
            "@typescript-eslint": typescriptEslintPlugin,
            react: reactPlugin,
        },

        rules: {
            ...typescriptEslintPlugin.configs.recommended.rules,

            "@typescript-eslint/consistent-type-imports": [
                "warn",
                {
                    prefer: "type-imports",
                    fixStyle: "separate-type-imports",
                },
            ],

            "@typescript-eslint/no-unused-vars": [
                "warn",
                {
                    argsIgnorePattern: "^_",
                    varsIgnorePattern: "^_",
                    caughtErrorsIgnorePattern: "^_",
                },
            ],

            "react/react-in-jsx-scope": "off",
            "react/jsx-uses-react": "off",
            "react/jsx-boolean-value": [
                "warn",
                "never",
            ],
            "react/self-closing-comp": "warn",
        },

        settings: {
            react: {
                version: "detect",
            },
        },
    },
]);
