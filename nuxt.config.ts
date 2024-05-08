import { defineNuxtConfig } from 'nuxt/config'
import { appDescription } from './constants/index'

export default defineNuxtConfig({
  modules: [
    // pre-installed
    '@vueuse/nuxt',
    '@pinia/nuxt',
    '@nuxtjs/color-mode',
    '@nuxt/devtools',

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
  ],

  nitro: {
    devProxy: {
      '/': {
        target: 'http://localhost:8080/',
        changeOrigin: true,
        prependPath: true,
      },
    },
    esbuild: {
      options: {
        target: 'esnext',
      },
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
          src: '/openbis/resources/api/v3/openbis.esm.js',
          type: 'module',
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

})
