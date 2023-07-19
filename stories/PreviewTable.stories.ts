import { entetyCombinations } from './wizzardTestObjects'
import PreviewTable from '@/components/Wizzard/PreviewTable.vue'

export default {
  title: 'Components/PreviewTable',
  component: PreviewTable,
  args: {
    modelValue: entetyCombinations, // modelValue prop with default value from entetyCombinations
  },
}

const Template = args => ({
  components: { PreviewTable },
  setup() {
    return { args }
  },
  template: '<PreviewTable v-bind="args" />',
})

export const Default = Template.bind({})
Default.args = {
  modelValue: entetyCombinations,
}
