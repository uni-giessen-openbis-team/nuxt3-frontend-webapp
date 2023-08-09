import { describe, expect, it } from 'vitest'
import { mount } from '@vue/test-utils'

import HelloWorld from '../HelloWorld.vue'

describe('HelloWorld', () => {
  it('is a Vue instance', () => {
    const wrapper = mount(HelloWorld)
    expect(wrapper.vm).toBeTruthy()
  })
})
