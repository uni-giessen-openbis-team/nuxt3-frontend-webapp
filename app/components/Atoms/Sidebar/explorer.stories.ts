import Explorer from './Explorer.vue';
import type { Meta, StoryObj } from '@storybook/vue3'
import { action } from '@storybook/addon-actions'


const meta = {
  component: Explorer,

  decorators: [() => ({ template: '<div style="margin: 3em;"><story/></div>' })],

}  satisfies Meta<typeof Explorer>

type Story = StoryObj<typeof meta>

export default meta;

// ... existing code ...

export const Default: Story = {
  render: () => ({
    template: '<Explorer />',
  }),

 
};