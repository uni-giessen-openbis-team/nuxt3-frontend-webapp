import SelectEntities from './SelectEntities.vue'
// More on how to set up stories at: https://storybook.js.org/docs/vue/writing-stories/introduction
import type { Meta, StoryObj } from '@storybook/vue3'

const sampleHandler = new EntitySampleHandler("1", "1", "1") 

const meta ={
  title: 'Wizard/SelectEntitiesStory',
  component: SelectEntities,
  args: { 
    modelValue: sampleHandler.properties , 
    items:sampleHandler?.items }, // default value
}  satisfies Meta<typeof SelectEntities>



export default meta

type Story = StoryObj<typeof meta>

export const SelectEntitiesStory: Story  = {
  args: { 
    modelValue: sampleHandler.properties , 
    items:sampleHandler?.items 
  },
}

export const SelectBiological: Story = {
  args: {
    modelValue: sampleHandler.properties,
    items: sampleHandler?.items
  },
}

  export const SelectTechnical: Story  = {
    args: { 
      modelValue: sampleHandler.properties , 
      items:sampleHandler?.items 
    },
  }

