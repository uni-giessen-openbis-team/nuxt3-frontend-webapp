import TextareaToList from './TextareaToList.vue';

export default {
  title: 'Components/Wizard/TextareaToList',
  component: TextareaToList,
};

const Template = (args: any) => ({
  components: { TextareaToList },
  setup() {
    return { args };
  },
  template: '<TextareaToList v-bind="args" />',
});

export const Default = Template.bind({});
Default.args = {
  // You can define default props here if needed
};