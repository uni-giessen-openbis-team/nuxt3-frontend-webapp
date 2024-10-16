import TextareaToList from './TextareaToList.vue';
import type { Meta, StoryObj } from '@storybook/vue3'



// Need to be imported because of the update:list event from the TextareaToList component
import { fn } from '@storybook/test'


const meta = {
  component: TextareaToList,
  args: {
    // Create a action in Storybook for the onUpdate:list event
    'onUpdate:list': fn(),
  }
}  satisfies Meta<typeof TextareaToList>

type Story = StoryObj<typeof meta>

export default meta

export const Default: Story = {

}  
