import { ErrorMessage, Field, Form, configure } from 'vee-validate'

export default defineNuxtPlugin((nuxtApp) => {
  nuxtApp.vueApp.component('VForm', Form)
  nuxtApp.vueApp.component('VField', Field)
  nuxtApp.vueApp.component('VErrorMessage', ErrorMessage)

  // Optional: configure global validation rules or custom settings
  configure({
    // your configuration here
  })
})
