import ListSpaces from './ListSpaces.vue';
import type { Meta, StoryObj } from '@storybook/vue3'

const meta = {
  title: "Test/ListSpaces",
  component: ListSpaces,

}  satisfies Meta<typeof ListSpaces>

type Story = StoryObj<typeof meta>

export default meta

export const Default: Story = {
  args: {

  }
}  
 