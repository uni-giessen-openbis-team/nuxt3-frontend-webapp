import ListSpaces from './ListTestVocabulary.vue';
import type { Meta, StoryObj } from '@storybook/vue3'

const meta = {
  title: "Test/ListTestVocabulary",
  component: ListSpaces,

}  satisfies Meta<typeof ListSpaces>

type Story = StoryObj<typeof meta>

export default meta

export const Default: Story = {
  args: {

  }
}  
 