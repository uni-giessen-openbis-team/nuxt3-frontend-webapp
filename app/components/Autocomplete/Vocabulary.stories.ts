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
  decorators: [
    () => ({
      setup() {
        const vocabularyTerms = ref([]);
        
        // Mock the onMounted lifecycle hook
        onMounted(async () => {
          vocabularyTerms.value = [
            { label: 'TEST_CODE', description: 'Test Description' },
            { label: 'TEST_CODE_2', description: 'Test Description 2' },
          ];
        });

        return { vocabularyTerms };
      },
    }),
  ],
  args: {
    searchTerm: "TEST_CODE",
    "onUpdate:selectedVocabulary": action("update:selectedVocabulary")
  }
}
