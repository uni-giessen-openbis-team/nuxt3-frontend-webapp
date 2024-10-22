import TestStorybookArgs from './TestStorybookArgs.vue';
import type { Meta, StoryObj } from '@storybook/vue3'

const meta = {
  title: "Test/TestStorybookArgs",

  component: TestStorybookArgs,

}  satisfies Meta<typeof TestStorybookArgs>

type Story = StoryObj<typeof meta>

export default meta

export const Default: Story = {
  args: {
    test: "dasdf"
  }
}  
  