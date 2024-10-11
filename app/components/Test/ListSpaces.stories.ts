import ListSpaces from './ListSpaces.vue';
import type { Meta, StoryObj } from '@storybook/vue3'

const meta = {
  title: "Test/ListSpaces",
  component: ListSpaces,

}  satisfies Meta<typeof ListSpaces>

type Story = StoryObj<typeof meta>

export default meta


jest.mock('./spacesService', () => ({
    getAllSpaces: jest.fn(() => [
      {
        id: '1',
        name: 'Mock Space',
        description: 'This is a mock space for testing purposes.',
      },
    ]),
  }));
  

export const Default: Story = {
  args: {
    getAllSpaces: () => [
        {
          id: '1',
          name: 'Mock Space',
          description: 'This is a mock space for testing purposes.',
        },
      ],
  }
}  
 