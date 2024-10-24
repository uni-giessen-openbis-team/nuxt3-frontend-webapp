<script setup lang="ts">
import { ref } from 'vue'
import type { Property , PropertyWithoutVocabulary} from '@/types/wizard'

const props = defineProps<{
  properties: Array<Property>; // Adjust the type as necessary
}>()

const emit = defineEmits<{
  (e: 'update:samples', selected: Property[]): void
}>()

const selectedProperties = ref<(Property| string) []>([])


function updateSelectedProperties(newVal: (Property| string) []){
  selectedProperties.value = newVal;
  const updatedProperties = newVal.map(property => {
    if (typeof property === 'string') {
    const out :  PropertyWithoutVocabulary = {
      title: property,
      description: "",  
      continuous: false,
      unit: null,
      conditions: [],
      }
      return out;
    }
    return property;
  });
  emit('update:samples', updatedProperties);
} 

</script>

<template>
  <v-combobox
    :model-value="selectedProperties"
    label="Experimental variables"
    box
    chips
    :items="props.properties"
    multiple
    @update:model-value="updateSelectedProperties"
  />
</template>