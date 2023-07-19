// plugins/vuetify.js
import type { ThemeDefinition } from 'vuetify'
import { createVuetify } from 'vuetify'
import * as components from 'vuetify/components'
import * as directives from 'vuetify/directives'
// Styles
import '@mdi/font/css/materialdesignicons.css'
import 'vuetify/styles'

export const myCustomLightTheme: ThemeDefinition = {
  dark: false,
  colors: {
    // 'background': '#edd7d79b',
    // 'surface': '#53a53c',
    // 'primary': '#4ca830',
    // 'primary-darken-1': '#dd4a42',
    // 'secondary': '#2b5954',
    // 'secondary-darken-1': '#192424',
    // 'error': '#B00020',
    // 'info': '#2196F3',
    // 'success': '#4CAF50',
    // 'warning': '#FB8C00',
  },
}

export const myCustomDarkTheme: ThemeDefinition = {
  dark: true,
  colors: {
    // add colors
  },
}

export default defineNuxtPlugin((nuxtApp) => {
  const vuetify = createVuetify({
    theme: {
      defaultTheme: 'myCustomLightTheme',
      themes: {
        myCustomLightTheme,
        myCustomDarkTheme,
      },
    },
    ssr: true,
    components,
    directives,

  })

  nuxtApp.vueApp.use(vuetify)
})
