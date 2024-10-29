import Sidebar from './Sidebar.vue';
import type { Meta, StoryObj } from '@storybook/vue3'
// import { action } from '@storybook/addon-actions'


const meta = {
  component: Sidebar,

}  satisfies Meta<typeof Sidebar>

type Story = StoryObj<typeof meta>

export default meta;

// ... existing code ...

export const Default: Story = {
  render: (args) => ({
    components: { Sidebar },
    setup() {
      return { args };
    },
    template: `
      <v-app>
        <Explorer v-bind="args" />
      </v-app>
    `,
  }),

};