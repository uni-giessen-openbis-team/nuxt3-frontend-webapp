import type { Preview } from "@storybook/vue3";
import { withVuetify } from 'storybook-addon-vuetify3/dist/decorators'
import { myCustomLightTheme } from "../plugins/useVuetify";

const preview: Preview = {
  parameters: {
    actions: { argTypesRegex: "^on[A-Z].*" },
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/,
      },
    },
  },
};

export default preview;

// Vuetify integration
export const globalTypes = {
  vuetify: {
    theme: {
      defaultTheme: 'myCustomLightTheme',
      themes: {
        myCustomLightTheme
      }
    }
  }
}

export const decorators = [
  withVuetify
]
