import { appDescription } from './constants/index'

export default defineNuxtConfig({
  modules: [
    // pre-installed
    '@vueuse/nuxt',
    '@unocss/nuxt',
    '@pinia/nuxt',
    '@nuxtjs/color-mode',
    '@vite-pwa/nuxt',
    '@nuxt/devtools',
    // '@nuxtjs/storybook',

    // own-imports
    '@formkit/nuxt',
    '@vue-macros/nuxt',
    'nuxt-lodash',
  ],

  experimental: {
    // when using generate, payload js assets included in sw precache manifest
    // but missing on offline, disabling extraction it until fixed
    payloadExtraction: false,
    // inlineSSRStyles: false,
  },
  css: [
    '@unocss/reset/tailwind.css',
    'vuetify/lib/styles/main.sass',
    '@mdi/font/css/materialdesignicons.min.css',
    'bootstrap/dist/css/bootstrap.min.css',
  ],
  build: {
    transpile: ['vuetify'],
  },
  colorMode: {
    classSuffix: '',
  },
  nitro: {
    devProxy: {
      '/openbis': {
        target: 'http://localhost:8080/openbis',
        changeOrigin: true,
        prependPath: true,
      },
    },
    esbuild: {
      options: {
        target: 'esnext',
      },
    },
    prerender: {
      crawlLinks: false,
      routes: ['/'],
      ignore: ['/hi'],
    },
  },
  app: {
    head: {
      viewport: 'width=device-width,initial-scale=1',
      link: [
        { rel: 'icon', href: '/favicon.ico', sizes: 'any' },
        { rel: 'icon', type: 'image/svg+xml', href: '/nuxt.svg' },
        { rel: 'apple-touch-icon', href: '/apple-touch-icon.png' },
      ],
      meta: [
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        { name: 'description', content: appDescription },
        { name: 'apple-mobile-web-app-status-bar-style', content: 'black-translucent' },
      ],

      script: [
        {
          src: '/openbis/resources/api/v3/config.bundle.js',
        },
        {
          src: '/openbis/resources/api/v3/require.js',
        },
        {
          src: 'http://localhost:3000/openbis/resources/api/v3/openbis.esm.js',
          hid: 'openbis',
        },
      ],
    },
  },
  ssr: false, // client side rendering only,
  runtimeConfig: {
    apiBase: process.env.API_BASE_URL,
  },
  // storybook: {
  //   url: 'http://localhost:6006',
  //   storybookRoute: '/__storybook__',
  //   port: 6006,
  // },
  plugins: ['~/plugins/openbis.client.js'],
})
