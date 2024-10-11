import TextareaToList from './CreateProperty.vue';
import type { Meta, StoryObj } from '@storybook/vue3'
import { action } from '@storybook/addon-actions'  // Correct import for action handlers
import type { Property } from '@/types/wizard'


const meta = {
  title: "Wizard/CreateProperty",
  component: TextareaToList,

}  satisfies Meta<typeof TextareaToList>

type Story = StoryObj<typeof meta>

export default meta

export const Default: Story = {
  args: {
    items: [
        { title: 'Property 1', description: 'Description 1', continuous: false, unit: null },
        { title: 'Property 2', description: 'Description 2', vocabularyCode: "TEST_CODE" },
      ] as Array<Property>,
  }
}  
 