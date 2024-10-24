import SelectProperties from './SelectProperties.vue';
import type { Meta, StoryObj } from '@storybook/vue3';
import { fn } from '@storybook/test'
import { propertyWithVocabulary, propertyWithoutVocabulary } from '../testData';

const meta : Meta<typeof SelectProperties> = {
  component: SelectProperties,
}; 

type Story = StoryObj<typeof meta>

export default meta


export const Default: Story = {
  // render: (args) => ({
  //   components: { SelectProperties },
  //   setup() {
  //     const value = ref(JSON.parse(JSON.stringify(args.properties)))
  //     return { value, args }
  //   },
  //   template: '<SelectProperties v-bind="args" v-model="value" />',
  // }),
  args: {
    properties: [
      propertyWithVocabulary,
      propertyWithoutVocabulary
    ],
    'onUpdate:samples': fn(),
  }, 
}

