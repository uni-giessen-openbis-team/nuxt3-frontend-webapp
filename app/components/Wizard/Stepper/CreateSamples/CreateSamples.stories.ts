import CreateSamples from './CreateSamples.vue';
import type { Meta, StoryObj } from '@storybook/vue3'
import { action } from '@storybook/addon-actions'
import { propertyWithVocabulary, propertyWithoutVocabulary } from '../testData'
import type { Property } from '@/types/wizard.js'

// props
export const  properties: Property[] = [
  propertyWithVocabulary,
  propertyWithoutVocabulary 
]

const args = {
  properties: properties,
  'onUpdate:return-samples': action('update:return-samples')
}

const meta = {
  component: CreateSamples,

}  satisfies Meta<typeof CreateSamples>

type Story = StoryObj<typeof meta>

export default meta

export const Default: Story = {
  args: args
};
