import { defineNuxtConfig } from 'nuxt/config'
import { appDescription } from './app/constants/index'


export default defineNuxtConfig({
  devtools: {
    enabled: false,
  },
  future: {
    compatibilityVersion: 4,
  },
  modules: [
    '@vueuse/nuxt',
    '@pinia/nuxt',
    '@nuxtjs/color-mode',
    '@formkit/nuxt',
    'vuetify-nuxt-module',
    '@pinia-plugin-persistedstate/nuxt',
    "@nuxt/eslint",
    '@nuxt/test-utils/module',
    '@nuxtjs/storybook'
  ],
  routeRules: {
    '/openbis/**': { proxy: 'http://localhost:8080/openbis/**' },
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
    },
  },

  // client side rendering only
  ssr: false,

  runtimeConfig: {
    apiBase: process.env.API_BASE_URL,
  },

  compatibilityDate: '2024-07-09',

  vuetify: {
    moduleOptions: {
      /* module specific options */
    },
    vuetifyOptions: {
      theme: {
        defaultTheme: 'dark',
      },
      labComponents: true
    }
  },
  // storybook issue https://github.com/nuxt-modules/storybook/issues/776
  vite: {
    optimizeDeps: {
      include: ['jsdoc-type-pratt-parser']
    },
    // https://github.com/nuxt/test-utils/blob/main/examples/app-vitest-full/nuxt.config.ts
    vue: {
      script: {
        defineModel: true,
      },
    },
  },
    
  testUtils: {
    startOnBoot: true,
  },
  storybook: {
    route: '/__storybook__',
    port: 6006,
  },
})
