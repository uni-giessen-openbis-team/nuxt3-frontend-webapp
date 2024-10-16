/** @type { import('storybook-vue').StorybookConfig } */
const config = {
    stories: [
      // '../app/components/**/*.mdx',
      '../app/components/**/*.stories.@(js|jsx|ts|tsx|mdx)',
      '../app/tests/storybook/**/*.stories.@(js|jsx|ts|tsx|mdx)',

      // '../app/pages/**/*.stories.@(js|jsx|ts|tsx|mdx)',
    ],
    addons: [
      '@storybook/addon-links',
      '@storybook/addon-essentials',
      '@chromatic-com/storybook',
      '@storybook/addon-interactions',
    ],
    framework: {
      name: '@storybook-vue/nuxt',
      options: {},
    },
    docs: {
      autodocs: 'tag',
    },
    //https://storybook.js.org/docs/builders/vite
    core: {
      builder: '@storybook/builder-vite', // 👈 The builder enabled here.
    },
  }
  export default config