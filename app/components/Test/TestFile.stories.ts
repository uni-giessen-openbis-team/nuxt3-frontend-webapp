import TestFile from './TestFile.vue'

// More on how to set up stories at: https://storybook.js.org/docs/vue/writing-stories/introduction
import type { Meta, StoryObj } from '@storybook/vue3'

const meta ={
  title: 'test/test',
  component: TestFile,
  args: { modelValue: "test"},

} satisfies Meta<typeof TestFile>



export default meta

/*
 *👇 Render functions are a framework specific feature
 to allow you control on how the component renders.
 * See https://storybook.js.org/docs/vue/api/csf
 * to learn how to use render functions.
 */


type Story = StoryObj<typeof meta>

export const TestStory: Story  = {

}
