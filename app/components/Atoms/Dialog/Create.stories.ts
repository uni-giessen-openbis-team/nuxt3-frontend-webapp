import Create from './Create.vue';
import type { Meta, StoryObj } from '@storybook/vue3'
// import { action } from '@storybook/addon-actions'


const meta = {
  component: Create,

}  satisfies Meta<typeof Create>

type Story = StoryObj<typeof meta>

export default meta;

export const Space: Story = {
  args: {
    name: "Space",
    createFunction: async (code, description) => {
      console.log("createFunction called with params: code: " + code + ", description: " + description);
    }
  }
};

