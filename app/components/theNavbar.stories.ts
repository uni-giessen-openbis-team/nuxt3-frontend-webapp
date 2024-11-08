import TheNavbar from './TheNavbar.vue';
import type { Meta, StoryObj } from '@storybook/vue3'
import { action } from '@storybook/addon-actions'


const meta = {
  component: TheNavbar,

}  satisfies Meta<typeof TheNavbar>

type Story = StoryObj<typeof meta>

export default meta;

// ... existing code ...

export const Default: Story = {
  args: {
  }

};