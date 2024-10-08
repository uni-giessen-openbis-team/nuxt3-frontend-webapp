import type { Meta, StoryObj } from '@storybook/vue3'

import CustomComponent from './CustomComponent.vue'

// More on how to set up stories at: https://storybook.js.org/docs/vue/writing-stories/introduction

/**
 * Shows how to use custom components (defined in the `components` folder) in a story.
 */
const meta = {
  title: 'Test/Custom Components',
  component: CustomComponent,
  argTypes: {
    backgroundColor: { control: 'color' },
    onClick: { action: 'clicked' },
  },
  args: { primary: false }, // default value
} satisfies Meta<typeof CustomComponent>

export default meta
type Story = StoryObj<typeof meta>
/*
 *👇 Render functions are a framework specific feature to allow you control on how the component renders.
 * See https://storybook.js.org/docs/vue/api/csf
 * to learn how to use render functions.
 */

export const SimpleComponent: Story = {
  args: { primary: true, label: 'Primary' },
}
