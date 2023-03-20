<script setup lang="ts">
import { computed, ref, toRefs, watch } from 'vue'
import { FormKitSchema } from '@formkit/vue'
// import type { FormKitSchemaComponent } from '@formkit/core'

import type { Version, VersionParameter } from './workflow-types'

interface FormKitSchemaComponentProps {
  label: string
  validation?: any[][]
  name: string
  help?: string
  type: string
  step?: number | string
  options?: string[]
  'validation-label'?: string
}

interface FormKitSchemaComponent {
  $cmp: string
  props: FormKitSchemaComponentProps
}

const props = defineProps({
  version: {
    type: Object as () => Version,
    required: true,
  },
  modelValue: {
    // Change the prop name to modelValue
    type: Object,
    required: true,
  },
})

const emit = defineEmits(['update:modelValue']) // Update the emit name

// variables
const isLoading = ref(false)
const data = ref(props.modelValue)
const { version } = toRefs(props)

// computed
const computedSchema = computed(() => {
  if (version?.value !== undefined) {
    console.log('wurst')
    const result = computeData(version.value.parameter_definition.parameters)
    return result.schema
  }
  else {
    return undefined
  }
})

// methods

// custom validation rule for file extensions
// https://formkit.com/essentials/validation#custom-rules
function createExtensionValidation(extensions: string[]) {
  return function (node: any) {
    console.log(node)
    return extensions.some(extension => node.value.endsWith(extension))
  }
}

function computeData(versionParameter: VersionParameter[]) {
  isLoading.value = true
  const schema: FormKitSchemaComponent[] = []
  data.value = {}

  if (versionParameter !== undefined) {
    for (const field of versionParameter) {
      // generate form fields
      const schemaField: FormKitSchemaComponent = generateSchemaField(field)

      // add the default value of the field to the data object
      if (field.default !== undefined) {
        if (field.default === 'true')
          data.value[field.name] = true
        else if (field.default === 'false')
          data.value[field.name] = false
        else
          data.value[field.name] = field.default
      }

      schema.push(schemaField)
    }
  }
  isLoading.value = false

  return { schema, data }
}

function updateData(value: any) {
  emit('update:modelValue', value) // Update the emit name
}
watch(data, () => {
  emit('update:modelValue', data.value) // Update the emit name
})

function generateSchemaField(field: VersionParameter): FormKitSchemaComponent {
  /// ////////// Init schema field ////////////
  const schemaField: FormKitSchemaComponent = {
    $cmp: 'FormKit',
    props: {
      label: field.label,
      validation: [],
      name: field.name,
      type: '',
    },
  }

  /// ///////// Optional field properties //////////
  // 1. Help
  if (field.caption)
    schemaField.props.help = field.caption

  // 2. Required?
  if (field.required === true) {
    if (schemaField.props.validation)
      schemaField.props?.validation.push(['required'])
  }
  /// ///////// Field types //////////
  /// / Checkboxes
  if (field.type === 'bool') {
    schemaField.props.type = 'checkbox'
  }

  /// / Number (int, float)
  else if (field.type === 'int' || field.type === 'float') {
    schemaField.props.type = 'number'
    // schemaField.props!.value = field.default || "0";
    // set steps
    schemaField.props.step
      = field.type === 'int' ? '1' : field.type === 'float' ? '0.01' : '1'
    schemaField.props.step
      = field.constraints?.interval?.steps || schemaField.props?.step
    // set min and max restriction
    if (field.constraints?.interval?.min) {
      if (schemaField.props.validation) {
        schemaField.props?.validation.push([
          'min',
          field.constraints.interval.min,
        ])
      }
    }
    if (field.constraints?.interval?.max) {
      if (schemaField.props.validation) {
        schemaField.props?.validation.push([
          'max',
          field.constraints.interval.max,
        ])
      }
    }
  }
  else if (field.type === 'string' || field.type === 'file') {
    if (field.constraints?.list) {
      schemaField.props.type = 'select'

      schemaField.props.options = field.constraints.list.filter(
        // TODO: Maybe filter is not required
        item => item !== '',
      )
    }
    else {
      /// / Textfield
      schemaField.props.type = 'text'
      // Text Restrictions Extension
      if (field.constraints?.extensions) {
        // for each element in the array, add a new validation rule

        const extensionValidation = createExtensionValidation(
          field.constraints?.extensions,
        ) // create Function
        if (schemaField.props.validation)
          schemaField.props.validation.push([extensionValidation])
        schemaField.props['validation-label']
          = `File extension must be one of the following: ${
           field.constraints?.extensions.join(', ')}`
      }
    }
  }
  if (schemaField.props?.validation) {
    if (schemaField.props?.validation.length === 0)
      delete schemaField?.props.validation
  }
  return schemaField
}
</script>

<template>
  <div v-if="isLoading">
    Loading form...
  </div>
  <div v-if="!isLoading">
    <div>Fill in the fom with the needed parameter</div>
    <div>
      <FormKit
        v-model="data"
        type="form"
        :actions="false"
        @update:model-value="updateData"
      >
        <FormKitSchema :schema="computedSchema" />
      </FormKit>
    </div>
  </div>
</template>

<style scoped>
button {
  margin-top: 16px;
}
</style>
