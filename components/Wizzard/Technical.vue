<script setup lang="ts">
// This comp
import { ref, watch } from 'vue'
const emit = defineEmits<{
  (event: 'update:modelValue', value: any): void
}>()
const METHODS = [{ title: 'DNA', counter: 1 }, { title: 'RNA', counter: 1 }]
const choosenMethods = ref([])

watch(choosenMethods, (newVal) => {
  emit('update:modelValue', newVal)
})
</script>

<template>
  <v-autocomplete
    v-model="choosenMethods"
    label="Analyte"
    box
    chips
    :items="METHODS"
    multiple
    return-object
  />
  <h4>Number of replicas</h4>
  <div v-for="item in choosenMethods" :key="item.title">
    {{ item.title }}
    <v-text-field
      v-model="item.counter"
      type="number"
    />
  </div>
  <pre>  {{ choosenMethods }}</pre>
</template>

<style lang="scss" scoped>

</style>
