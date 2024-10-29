import CreateSpace from './CreateSpace.vue';
import type { Meta, StoryObj } from '@storybook/vue3'
// import { action } from '@storybook/addon-actions'


const meta = {
  component: CreateSpace,

}  satisfies Meta<typeof CreateSpace>

type Story = StoryObj<typeof meta>

export default meta;

export const Space: Story = {
  args: {
   
  }
};

