import Space from './index.vue';
import type { Meta, StoryObj } from '@storybook/vue3'
// import { action } from '@storybook/addon-actions'


const meta = {
  component: Space,

}  satisfies Meta<typeof Space>

type Story = StoryObj<typeof meta>

export default meta;

export const Default: Story = {
  args: {
  }
};