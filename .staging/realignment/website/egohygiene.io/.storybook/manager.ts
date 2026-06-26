/**
 * @file manager.ts
 * @description Configures the Storybook Manager UI theme and manager-level settings.
 * Applies a custom theme based on the base dark theme.
 * @version 1.1.0
 */

import { addons } from "@storybook/manager-api";
import { themes, ThemeVars } from "@storybook/theming";

// Optional: Create a custom dark theme by extending the base
const egoHygieneTheme: ThemeVars = {
  ...themes.dark,
  brandTitle: "Ego Hygiene",
  brandUrl: "https://egohygiene.io",
  brandImage: "/public/favicon.svg", // Make sure this file exists
  base: "dark",
  appBg: "#0d1117",
  appContentBg: "#0d1117",
  colorPrimary: "#7c3aed",   // violet-600
  colorSecondary: "#f472b6"  // pink-400
};

addons.setConfig({
  theme: egoHygieneTheme
});
