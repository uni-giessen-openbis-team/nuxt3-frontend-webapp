import PoolSamples from './PoolSamples.vue';
import type { Meta, StoryObj } from '@storybook/vue3'
import type { Sample } from '@/types/wizard'


export const samples:Sample[] = [
  {
      sampleType: 'Sample Type 1',
      externalDBID: '1',
      name: 'Sample 1',
      count: 1,
      conditions: [
          {
              propertyTitle: 'Property 1',
              conditionTerm : 'Condition 2'
          },
          {
              propertyTitle: 'Property 2',
              conditionTerm : 'Condition 3'
          }
      ]
  },
  {
      sampleType: 'Sample Type 2',
      externalDBID: '2',
      name: 'Sample 2',
      count: 2,
      conditions: [
          {
              propertyTitle: 'Property 2',
              conditionTerm : 'Condition 3'
          }
      ]
  }
]

const meta = {
  component: PoolSamples,

}  satisfies Meta<typeof PoolSamples>

type Story = StoryObj<typeof meta>

export default meta

export const Default: Story = {
  args: {
   samples:samples
  }  
}
