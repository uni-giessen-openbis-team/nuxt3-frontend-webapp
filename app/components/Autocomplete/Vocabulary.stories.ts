import TextareaToList from './Vocabulary.vue';
import type { Meta, StoryObj } from '@storybook/vue3'
import { action } from '@storybook/addon-actions'  // Correct import for action handlers
import type { Property } from '@/types/wizard'


const meta = {
  title: "Wizard/Vocabulary",
  component: TextareaToList,

}  satisfies Meta<typeof TextareaToList>

type Story = StoryObj<typeof meta>



export default meta

export const Default: Story = {
  args: {
    searchTerm: "TEST_CODE",
    "onUpdate:selectedVocabulary": action("update:selectedVocabulary")
    
}
}  
