<script setup lang="ts">
import { ref, watch } from 'vue'
import type { Property , PropertyWithoutVocabulary} from '@/types/wizard'

const props = defineProps<{
  items: Array<Property>; // Adjust the type as necessary
}>()

const emit = defineEmits<{
  (e: 'update:selectedProperties', selected: Property[]): void
}>()

const selectedProperties = ref<(Property| string) []>([])


watch(selectedProperties, (newVal) => {
  const updatedProperties = newVal.map(item => {
    if (typeof item === 'string') {
      return {
        title: item,
        description: "",  
        continuous: false,
        unit: null
      } as PropertyWithoutVocabulary;
    }
    return item;
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
    :items="props.items"
    multiple
  />
</template>