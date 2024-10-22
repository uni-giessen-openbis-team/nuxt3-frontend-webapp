import TwoTables from './twoTables.vue';
import type { Meta, StoryObj } from '@storybook/vue3'

const meta = {
    title: "Test/vueDragable",

  component: TwoTables
,

}  satisfies Meta<typeof TwoTables>

type Story = StoryObj<typeof meta>

export default meta

export const Default: Story = {

}  
  