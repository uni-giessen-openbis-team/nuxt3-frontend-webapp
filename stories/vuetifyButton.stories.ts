import ButtonComponent from '../components/Test/TestButtton.vue'

export default {
  title: 'Components/ButtonComponent',
  component: ButtonComponent,
}

const Template = (args, { argTypes }) => ({
  props: Object.keys(argTypes),
  components: { ButtonComponent },
  template: '<ButtonComponent />',
})

export const Default = Template.bind({})
