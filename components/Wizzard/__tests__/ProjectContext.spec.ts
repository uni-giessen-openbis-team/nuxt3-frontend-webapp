import { describe, expect, it } from 'vitest'
import { mountSuspended } from 'vitest-environment-nuxt/utils'
import ProjectContext from '@/components/Wizzard/ProjectContext.vue'

const simulateTyping = (element: HTMLInputElement | HTMLTextAreaElement, value: string) => {
  element.value = value
  element.dispatchEvent(new Event('input'))
}

describe('ProjectContext.vue', () => {
  it('renders correctly with initial state', async () => {
    const component = await mountSuspended(ProjectContext, {
      props: {
        modelValue: {
          UUID: '',
          space: null,
          name: null,
          contactPerson: null,
          manager: null,
          description: null,
        },
      },
    })

    expect(component.html()).toContain('New Project Name')
    expect(component.html()).toContain('Contact Person')
    expect(component.html()).toContain('Project Manager')
    expect(component.html()).toContain('Description')
  })

  it('updates modelValue correctly', async () => {
    const component = await mountSuspended(ProjectContext, {
      props: {
        modelValue: {
          UUID: '',
          space: null,
          name: null,
          contactPerson: null,
          manager: null,
          description: null,
        },
      },
    })
    console.log(component.html())

    // Simulate selection in AutocompleteSpaces component
    const autocompleteSpaces = component.findComponent({ name: 'AutocompleteSpaces' })
    autocompleteSpaces.setValue('DEFAULT')
    await component.vm.$nextTick()

    // Simulate typing in various fields
    const projectNameInput = component.find('input[label="New Project Name"]').element as HTMLInputElement
    simulateTyping(projectNameInput, 'Test Project Name')

    const contactPersonInput = component.find('input[label="Contact Person"]').element as HTMLInputElement
    simulateTyping(contactPersonInput, 'Test Contact Person')

    const managerInput = component.find('input[label="Project Manager"]').element as HTMLInputElement
    simulateTyping(managerInput, 'Test Project Manager')

    const descriptionArea = component.find('textarea[label="Description"]').element as HTMLTextAreaElement
    simulateTyping(descriptionArea, 'This is a test description for the project')

    await component.vm.$nextTick()

    // Validate that modelValue is updated correctly

    const expectedModelValue = {
      space: 'DEFAULT',
      name: 'Test Project Name',
      contactPerson: 'Test Contact Person',
      manager: 'Test Project Manager',
      description: 'This is a test description for the project',
      UUID: '', // add whatever UUID is supposed to be here
    }

    const updatedModelValue = component.props('modelValue')
    expect(updatedModelValue).toEqual(expectedModelValue)
  })
  it('validates the minimum length of the description', async () => {
    const component = await mountSuspended(ProjectContext, {
      props: {
        modelValue: {
          UUID: '',
          space: null,
          name: null,
          contactPerson: null,
          manager: null,
          description: null,
        },
      },
    })

    // Locate textarea and simulate typing a short description
    const descriptionArea = component.find('textarea[label="Description"]').element as HTMLTextAreaElement
    simulateTyping(descriptionArea, 'Short')

    await component.vm.$nextTick()

    // Check if validation message appears
    expect(component.html()).toContain('Item must be at least 20 characters')
  })
  // ...additional test cases
})
