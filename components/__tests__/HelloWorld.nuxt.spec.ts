import { expect, it } from 'vitest'
import { mountSuspended } from 'vitest-environment-nuxt/utils'

import HelloWorld from '../HelloWorld.vue'

it('is a Vue instance', async () => {
  const component = await mountSuspended(HelloWorld)
  expect(component.vm).toBeTruthy()
})

it('renders text correctly', async () => {
  const mockText = 'Test Text'
  const component = await mountSuspended(HelloWorld, {
    props: { text: mockText },
  })

  const vTextComponent = component.find('v-text')
  expect(vTextComponent.text()).toContain(mockText)
})
 