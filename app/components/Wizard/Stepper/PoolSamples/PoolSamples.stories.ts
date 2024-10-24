import PoolSamples from './PoolSamples.vue';
import type { Meta, StoryObj } from '@storybook/vue3'
import type { Sample } from '@/types/wizard'


 const samples:Sample[] = [
  {
    id: '1',
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
    ],
    pools: []
  },
  {
    id: '2',
    externalDBID: '2',
    name: 'Sample 2',
    count: 2,
    conditions: [
        {
            propertyTitle: 'Property 2',
            conditionTerm : 'Condition 3'
        }
    ],
    pools: ['Pool 1']
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
