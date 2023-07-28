import ButtonComponent from '../components/Hello.vue';

export default {
  title: 'Components/ButtonComponent',
  component: ButtonComponent,
};


const Template = (args, { argTypes }) => ({
    props: Object.keys(argTypes),
    components: { ButtonComponent },
    template: '<ButtonComponent />',
  });
  
  export const Default = Template.bind({});