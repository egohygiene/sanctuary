/**
 * ----------------------------------------------------------------------------
 * Prettier Configuration
 * ----------------------------------------------------------------------------
 *
 * Purpose:
 *   Establish consistent formatting behavior across repositories,
 *   languages, and tooling environments.
 *
 * Design Goals:
 *   - conservative universal defaults
 *   - cross-language compatibility
 *   - minimal configuration noise
 *   - predictable formatting behavior
 *
 * Reference:
 *   https://prettier.io/docs/configuration
 *
 * ----------------------------------------------------------------------------
 */

/**
 * @type {import("prettier").Config}
 */
const prettierConfiguration = {
    // -------------------------------------------------------------------------
    // Core Formatting
    // -------------------------------------------------------------------------

    semi: true,
    singleQuote: false,
    trailingComma: "all",

    // -------------------------------------------------------------------------
    // Readability
    // -------------------------------------------------------------------------

    arrowParens: "always",
    bracketSameLine: false,
    objectWrap: "preserve",
    proseWrap: "preserve",

    // -------------------------------------------------------------------------
    // Platform Consistency
    // -------------------------------------------------------------------------

    endOfLine: "lf",

    // -------------------------------------------------------------------------
    // Overrides
    // -------------------------------------------------------------------------

    overrides: [
        {
            files: ["*.json", "*.json5"],
            options: {
                tabWidth: 2,
                printWidth: 80,
                trailingComma: "none",
            },
        },

        {
            files: ["*.md", "*.markdown", "*.mdx"],
            options: {
                proseWrap: "preserve",
                tabWidth: 2,
            },
        },

        {
            files: ["*.yml", "*.yaml"],
            options: {
                tabWidth: 2,
            },
        },
    ],
};

export default prettierConfiguration;
