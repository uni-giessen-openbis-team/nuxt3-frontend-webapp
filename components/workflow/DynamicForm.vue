<script setup lang="ts">
import { computed, ref, toRefs, watch } from 'vue'
import type { Version } from './workflow-types'

const props = defineProps({
  version: {
    type: Object as () => Version,
    required: true,
  },
  modelValue: {
    type: Object,
    required: true,
  },
})

const emit = defineEmits(['update:modelValue'])

// variables
const isLoading = ref(false)
const data = ref(props.modelValue)
const { version } = toRefs(props)

// computed
const computedVersionParameters = computed(() => {
  if (version.value !== undefined)
    return version.value.parameter_definition.parameters

  else
    return undefined
})

// methods
function updateData(value: any) {
  emit('update:modelValue', value)
}

watch(data, () => {
  emit('update:modelValue', data.value)
})
</script>

<template>
  <div>Fill in the form with the needed parameters</div>
  <v-form @input="() => emit('update:modelValue', data.value)">
    <template v-for="field in version.parameter_definition.parameters" :key="field.name">
      <v-select
        v-if="field.type === 'string' && field.constraints?.list"
        v-model="data[field.name]"
        :label="field.label"
        :name="field.name"
        :items="field.constraints.list"
        :required="field.required"
        :help="field.caption"
      />
      <v-text-field
        v-else-if="field.type === 'string'"
        v-model="data[field.name]"
        :label="field.label"
        :name="field.name"
        :required="field.required"
        :help="field.caption"
        :rules="[]"
      />
      <v-checkbox
        v-else-if="field.type === 'bool'"
        v-model="data[field.name]"
        :label="field.label"
        :name="field.name"
      />

      <v-file-input
        v-else-if="field.type === 'file'"
        v-model="data[field.name]"
        :label="field.label"
        :name="field.name"
        :required="field.required"
        :help="field.caption"
        :rules="[]"
      />
      <v-text-field
        v-else-if="field.type === 'int' || field.type === 'float'"
        v-model="data[field.name]"
        :label="field.label"
        :name="field.name"
        :type="field.type === 'int' ? 'number' : 'decimal'"
        :step="field.type === 'int' ? '1' : '0.01'"
        :required="field.required"
        :help="field.caption"
        :rules="[]"
      />
    </template>
  </v-form>
</template>

<style scoped>
button {
  margin-top: 16px;
}
</style>
