import TextareaToList from './AddUnitToProperty.vue';
import type { Meta, StoryObj } from '@storybook/vue3'
import { action } from '@storybook/addon-actions'  // Correct import for action handlers



const meta = {
  component: TextareaToList,

}  satisfies Meta<typeof TextareaToList>

type Story = StoryObj<typeof meta>

export default meta

export const Default: Story = {
  args: {
    "onUpdate:continuous": action('update-continuous'),
    "onUpdate:unit": action('update-unit'),
  }
}  
