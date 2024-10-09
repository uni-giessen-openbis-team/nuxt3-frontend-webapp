import SelectEntities from './SelectEntities.vue'
// More on how to set up stories at: https://storybook.js.org/docs/vue/writing-stories/introduction
import type { Meta, StoryObj } from '@storybook/vue3'

const entitySampleHandler = ref(new EntitySampleHandler("1", "1", "1")) 
entitySampleHandler.value.properties = entitySampleHandler.value.items
entitySampleHandler.value.createSampleCreations()

const meta ={
  title: 'Wizard/SelectEntitiesStory',
  component: SelectEntities,
}  satisfies Meta<typeof SelectEntities>

export default meta

type Story = StoryObj<typeof meta>

export const SelectEntitiesStory: Story  = {
  args: { 
    modelValue: entitySampleHandler.value.properties , 
    items:entitySampleHandler.value.items 
  },
}

