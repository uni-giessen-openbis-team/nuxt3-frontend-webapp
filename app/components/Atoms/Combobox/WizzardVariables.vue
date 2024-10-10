<template>
  <div>
    <v-combobox
      v-model="formattedEntityVariables"
      v-bind="props"
      box
      chips
      multiple
      return-object
    />
  </div>
</template>

<script lang="ts" setup>
import { computed, toRefs } from 'vue'

const props = defineProps({
  variables: {
    type: Array,
    required: true
  },
  entityVariables: {
    type: Array,
    required: true
  },
})

const { variables, entityVariables } = toRefs(props)

const formattedEntityVariables = computed({
  get() {
    return entityVariables.value.map(item => {
      if (typeof item === 'string') {
        return {
          title: item,
          conditions: [],
          continuous: false,
          unit: null,
          vocabularyCode: ""
        }
      }
      return item
    })
  },
  set(newValue) {
    entityVariables.value = newValue
  }
})
</script>

<style>

</style>