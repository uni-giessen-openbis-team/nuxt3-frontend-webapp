import { defineNuxtConfig } from 'nuxt/config'
import { appDescription } from './constants/index'


export default defineNuxtConfig({
  modules: [
    '@vueuse/nuxt',
    '@pinia/nuxt',
    '@nuxtjs/color-mode',
    '@formkit/nuxt',
    'vuetify-nuxt-module',
    '@pinia-plugin-persistedstate/nuxt',
    "@nuxt/eslint"
  ],
  
  nitro: {
    devProxy: {
      '/openbis': {
        target: 'http://localhost:8080/openbis',
        changeOrigin: true,
        prependPath: true,
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
    },
  },
  ssr: false, // client side rendering only

  runtimeConfig: {
    apiBase: process.env.API_BASE_URL,
  },

})