// tests/components/SomeComponents.nuxt.spec.ts
import { mountSuspended } from '@nuxt/test-utils/runtime'
import  testComponent from '@/components/testComponent.vue'
import { expect, it } from 'vitest'

it('can mount some component', async () => {
    const component = await mountSuspended(testComponent)
    expect(component.text()).toMatchInlineSnapshot(
        `"Hello world"`
    )
})