<script setup lang="ts">
// This comp
import { ref } from 'vue'

const { modelValue } = defineModels<{ modelValue: Array<Object> }>()

const METHODS = ref(['DNA', 'RNA'])
</script>

<template>
  <v-autocomplete
    v-model="modelValue[0].conditions"
    label="Analyte"
    box
    chips
    :items="METHODS"
    multiple
    return-object
  />
</template>

<style lang="scss" scoped>

</style>
