import SelectProperties from './SelectProperties.vue';
import type { Meta, StoryObj } from '@storybook/vue3';
import { fn } from '@storybook/test'
import { propertyWithVocabulary, propertyWithoutVocabulary } from '../testData';

const meta = {
  component: SelectProperties,
  args: {
    items: [
      propertyWithVocabulary,
      propertyWithoutVocabulary
    ],
    'onUpdate:selectedProperties': fn(),
  },


} satisfies Meta<typeof SelectProperties>

type Story = StoryObj<typeof meta>

export default meta


export const Default: Story = {

}

