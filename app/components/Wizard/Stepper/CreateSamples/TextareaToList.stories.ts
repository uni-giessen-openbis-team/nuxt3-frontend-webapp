import TextareaToList from './TextareaToList.vue';
import type { Meta, StoryObj } from '@storybook/vue3'
import { fn } from '@storybook/test'

const meta = {
  component: TextareaToList,

}  satisfies Meta<typeof TextareaToList>

type Story = StoryObj<typeof meta>

export default meta

export const Default: Story = {
  args: {
    // Create a action in Storybook for the onUpdate:list event
    'onUpdate:list': fn(),
  },
  // render: (args) => ({
  //   components: { TextareaToList },
  //   setup() {
  //     const value = ref(  args.list ?  JSON.parse(JSON.stringify( args.list  )) : undefined )
  //     return { value, args }
  //   },
  //   template: '<TextareaToList v-bind="args" v-model:list="value" />',
  // }),
}  
