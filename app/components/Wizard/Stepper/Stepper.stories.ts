import TextareaToList from './Stepper.vue';
import type { Meta, StoryObj } from '@storybook/vue3'
import { action } from '@storybook/addon-actions'


const meta = {
  component: TextareaToList,

}  satisfies Meta<typeof TextareaToList>

type Story = StoryObj<typeof meta>

export default meta;

export const Default: Story = {
  args: {
    onUpdateSamples: action('updateSamples'),
  }
};