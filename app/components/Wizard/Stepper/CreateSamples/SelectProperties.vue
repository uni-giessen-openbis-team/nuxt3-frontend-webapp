<script setup lang="ts">
import { ref, watch } from 'vue'
import type { Property , PropertyWithoutVocabulary} from '@/types/wizard'

const props = defineProps<{
  properties: Array<Property>; // Adjust the type as necessary
}>()

const emit = defineEmits<{
  (e: 'update:selectedProperties', selected: Property[]): void
}>()

const selectedProperties = ref<(Property| string) []>([])


watch(selectedProperties, (newVal) => {
  const updatedProperties = newVal.map(property => {
    if (typeof property === 'string') {
      return {
        title: property,
        description: "",  
        continuous: false,
        unit: null
      } as PropertyWithoutVocabulary;
    }
    return property;
  });
  emit('update:selectedProperties', updatedProperties);
})
</script>

<template>
  <v-combobox
    v-model="selectedProperties"
    label="Experimental variables"
    box
    chips
    :items="props.properties"
    multiple
  />
</template>