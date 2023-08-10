import { test } from 'vitest'
import { mockNuxtImport, registerEndpoint } from 'nuxt-vitest/utils'

test('my test', () => {
  // ... test with Nuxt environment!
})

// mock storage
mockNuxtImport('useStorage', () => {
  return () => {
    return { value: 'mocked storage' }
  }
})

// mock API data
registerEndpoint('/test/', () => {
  test: 'test-field'
})
