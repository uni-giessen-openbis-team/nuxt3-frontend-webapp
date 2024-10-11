import SelectProperties from './SelectProperties.vue';
import type { Meta, StoryObj } from '@storybook/vue3';
import type { Property } from '@/types/wizard';
import { fn } from '@storybook/test'

const meta = {
  title: "Wizard/SelectProperties",
  component: SelectProperties,
  args : {
    items: [
      { title: 'Property 1', description: 'Description 1', continuous: false, unit: null },
      { title: 'Property 2', description: 'Description 2', vocabularyCode: "TEST_CODE" },
    ] as Array<Property>,
    'onUpdate:selectedProperties': fn(),
  },


}  satisfies Meta<typeof SelectProperties>

type Story = StoryObj<typeof meta>

export default meta 


export const Default: Story = {
 
}  

