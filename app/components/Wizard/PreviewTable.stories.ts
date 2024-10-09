import PreviewTable from './PreviewTable.vue';
import type { Meta, StoryObj } from '@storybook/vue3';

import openbis from '~/composables/openbis.esm';

const sampleCreation = new openbis.SampleCreation()
sampleCreation.setProperties({
  "name": "name",
  "code": "code",
  "description": "description",
  "type": "type",
  "space": "space",
  "project": "project",
  "experiment": "experiment",
})
sampleCreation.setCode("test")


const meta: Meta<typeof PreviewTable> = {
  title: 'Wizard/PreviewTable',
  component: PreviewTable,

};

export default meta;

type Story = StoryObj<typeof meta>;

export const EntityPreviewTable: Story = {
  args: {
    modelValue: [sampleCreation],
  },
};

