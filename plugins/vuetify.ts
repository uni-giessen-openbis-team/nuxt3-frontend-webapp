// Integrate Vuetify as a plugin: https://www.youtube.com/watch?v=xB7c0G3kVuw&t=320s

import { createVuetify } from 'vuetify'
import * as components from 'vuetify/components'
import * as directives from 'vuetify/directives'

export default defineNuxtPlugin((nuxtApp) => {
  const vuetify = createVuetify({
    components,
    directives,
    theme: {
      defaultTheme: 'dark',
    },
  })
  nuxtApp.vueApp.use(vuetify)
})
