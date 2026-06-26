import { type StorybookConfig } from "@storybook/react-vite";
import { mergeConfig, type InlineConfig } from "vite";
import path from "node:path";

const projectRoot: string = path.resolve(__dirname, "../");

const config: StorybookConfig = {
  addons: [
    "@storybook/addon-essentials",
    "@storybook/addon-links",
    "@storybook/addon-interactions",
    "@storybook/addon-a11y",
    "@storybook/addon-themes",
    "@storybook/addon-mdx-gfm"
  ],
  core: {
    builder: {
      name: "@storybook/builder-vite",
      options: {
        viteConfigPath: path.resolve(projectRoot, "vite.config.ts")
      }
    },
    renderer: "@storybook/react",
    disableWebpackDefaults: true,
    disableProjectJson: false,
    disableTelemetry: true,
    enableCrashReports: false,
    disableWhatsNewNotifications: true,
    crossOriginIsolated: true
  },
  staticDirs: [
    {
      from: path.resolve(projectRoot, "public"),
      to: '/public'
    }
  ],
  logLevel: "info",
  features: {
    viewport: true,
    highlight: true,
    backgrounds: true,
    measure: true,
    outline: true,
    controls: true,
    interactions: true,
    actions: true,
    disallowImplicitActionsInRenderV8: true,
    angularFilterNonInputControls: false,
  },
  build: {
    test: {
      disableBlocks: false,
      disabledAddons: [],
      disableMDXEntries: false,
      disableAutoDocs: false,
      disableDocgen: false,
      disableSourcemaps: false,
      disableTreeShaking: false,
      esbuildMinify: false
    }
  },
  stories: [
    path.resolve(projectRoot, "src/**/*.stories.@(ts|tsx|mdx)")
  ],
  framework: {
    name: "@storybook/react-vite",
    options: {
      builder: {
        viteConfigPath: path.resolve(projectRoot, "vite.config.ts")
      },
      strictMode: true,
      legacyRootApi: false
    },
  },
  typescript: {
    check: true,
    skipCompiler: false,
    reactDocgen: "react-docgen-typescript",
    reactDocgenTypescriptOptions: {
      tsconfigPath: path.resolve(projectRoot, "tsconfig.json"),
    }
  },
  refs: {},
  babel: {},
  swc: {},
  env: (env = {}) => ({
    ...env,
    ESLINT_NO_DEV_ERRORS: "true",
    DISABLE_ESLINT_PLUGIN: "true"
  }),
  babelDefault: {},
  previewAnnotations: [],
  experimental_indexers: [],
  docs: {
    defaultName: 'Documentation',
  },
  tags: {},
  async viteFinal(config: InlineConfig, { configType }) {
    return mergeConfig(config, {
      resolve: {
        alias: {
          "@egohygiene": path.resolve(projectRoot, "src")
        }
      }
    });
  }
};

export default config;
