import TheLoginForm from '@/components/TheLoginForm.vue'

export default {
  title: '"Components/TheLoginForm',
  component: TheLoginForm,
}

const Template = (args, { argTypes }) => ({
  props: Object.keys(argTypes),
  components: { TheLoginForm },
  template: '<TheLoginForm v-bind="$props" />',
})

export const Default = Template.bind({})
Default.args = {
  // You can set your default args here if any
}
 