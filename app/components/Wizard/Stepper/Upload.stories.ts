import Upload from './Upload.vue';
import type { Meta, StoryObj } from '@storybook/vue3'



const meta = {
  component: Upload,

}  satisfies Meta<typeof Upload>

type Story = StoryObj<typeof meta>

export default meta

export const Default: Story = {
  args: {
 
  }
}  
