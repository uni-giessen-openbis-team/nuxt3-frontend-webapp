import SelectProperties from './SelectProperties.vue';
import type { Meta, StoryObj } from '@storybook/vue3';
import { fn } from '@storybook/test'

const meta = {
  component: SelectProperties,
  args : {
    items: [
      { title: 'Property 1', description: 'Description 1', continuous: false, unit: null , conditions: []},
      { title: 'Property 2', description: 'Description 2', vocabularyCode: "TEST" , conditions: []},
    ] ,
    'onUpdate:selectedProperties': fn(),
  },


}  satisfies Meta<typeof SelectProperties>

type Story = StoryObj<typeof meta>

export default meta 


export const Default: Story = {
 
}  

