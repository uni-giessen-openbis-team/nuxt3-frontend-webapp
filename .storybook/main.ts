/** @type { import('storybook-vue').StorybookConfig } */
const config = {
    stories: [
      '../app/components/**/*.mdx',
      '../app/components/**/*.stories.@(js|jsx|ts|tsx|mdx)',
      '../app/pages/**/*.stories.@(js|jsx|ts|tsx|mdx)',
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
    proxy: {
      '/api/': {
        target: 'http://localhost:8080/openbis',
        changeOrigin: true,
        pathRewrite: { '^/openbis/': '' },
      },
    },

  }
  export default config