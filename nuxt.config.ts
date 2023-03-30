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

    // own-imports
    '@formkit/nuxt',
    '@vue-macros/nuxt',

  ],
  experimental: {
    // when using generate, payload js assets included in sw precache manifest
    // but missing on offline, disabling extraction it until fixed
    payloadExtraction: false,
    inlineSSRStyles: false,
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
    },
  },
  pwa: {
    // TODO: Change Icon, description, etc.
    manifest: {
      name: 'OpenBIZ Plus',
      short_name: 'OpenBIZ',
      description: 'Website to store and distribute biological data',
      icons: [{
        src: '/icons/icon_144x144.png',
        sizes: '144x144',
        type: 'image/png',
      }],
    },
    workbox: {
      navigateFallback: '/',
    },
    devOptions: {
      enabled: true,
      type: 'module',
    },
  },
  ssr: false, // client side rendering only
})
