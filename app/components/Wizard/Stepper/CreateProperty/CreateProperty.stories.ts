import TextareaToList from './CreateProperty.vue';
import type { Meta, StoryObj } from '@storybook/vue3'
import type { Property } from '@/types/wizard'
import { action } from '@storybook/addon-actions'
import { userEvent, within } from '@storybook/test';

const meta = {
  component: TextareaToList,

}  satisfies Meta<typeof TextareaToList>

type Story = StoryObj<typeof meta>

export default meta

export const Default: Story = {

  args: {
    items: [
        { title: 'Property Without Vocabulary', description: 'Description 1', continuous: false, unit: null },
        { title: 'Property With Vocabulary', description: 'Description 2', vocabularyCode: "TEST" },
      ] as Array<Property>,
      'onUpdate:return-samples': action('update:return-samples')
  },
  play:  async ({ canvasElement }) => {
    const canvas = within(canvasElement);
 
    // Simulate selecting both properties
    const selectProperties = canvas.getByRole('combobox');
    await userEvent.selectOptions(selectProperties, [
      'Property Without Vocabulary',
      'Property With Vocabulary',
    ]);

    // Simulate entering values in the textarea for the property without vocabulary
    const textarea = canvas.getByRole('textbox', { name: /conditions/i });
    await userEvent.type(textarea, 'Condition 1, Condition 2');

    // Simulate selecting terms from the vocabulary for the property with vocabulary
    const autocomplete = canvas.getByRole('combobox', { name: /vocabulary/i });
    await userEvent.selectOptions(autocomplete, ['Term 1', 'Term 2']);
  },
}  
 