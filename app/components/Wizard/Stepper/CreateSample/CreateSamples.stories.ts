import TextareaToList from './CreateSamples.vue';
import type { Meta, StoryObj } from '@storybook/vue3'
import type { Property } from '@/types/wizard'
import { action } from '@storybook/addon-actions'

const meta = {
  component: TextareaToList,

}  satisfies Meta<typeof TextareaToList>

type Story = StoryObj<typeof meta>

export default meta

export const Default: Story = {
  args: {
    items: [
        { title: 'Property Without Vocabulary', description: 'Description 1', continuous: false, unit: null },
        { title: 'Property With Vocabulary', description: 'Description 2', vocabularyCode: "TEST" },
      ] as Array<Property>,
      'onUpdate:return-samples': action('update:return-samples')
  }
}  
 