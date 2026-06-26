import type { Preview } from "@storybook/react";
import { themes } from "@storybook/theming";

const preview: Preview = {
  parameters: {
    actions: { argTypesRegex: "^on[A-Z].*" },
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/
      }
    },
    docs: {
      theme: themes.dark
    },
    layout: "fullscreen"
  },
  decorators: [],
    //👇 Enables auto-generated documentation for all stories
  tags: ['autodocs'],
};

export default preview;
