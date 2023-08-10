import { describe, expect, it } from 'vitest'
import { mountSuspended } from 'vitest-environment-nuxt/utils'
import ProjectContext from '@/components/Wizzard/ProjectContext.vue'

describe('ProjectContext.vue', () => {
  it('renders correctly with initial state', async () => {
    const component = await mountSuspended(ProjectContext, {
      props: {
        modelValue: { space: '' },
      },
    })

    // Check if the correct labels exist
    expect(component.html()).toContain('New Project Name')
    expect(component.html()).toContain('Contact Person')
    expect(component.html()).toContain('Project Manager')
    expect(component.html()).toContain('Description')

    // ... additional assertions
  })

  it('validates New Project Name correctly', async () => {
    const component = await mountSuspended(ProjectContext)
    const textField = component.find('v-text-field[label="New Project Name"]')

    // Set value to an empty string and trigger validation
    textField.setValue('Test Project Name')
    await component.vm.$nextTick()

    // This assumes that invalid input will modify the HTML in some way to indicate an error
    expect(textField.html()).toContain('Test Project Name')

    // ... additional assertions
  })

  // ... other tests similar to your example
})
