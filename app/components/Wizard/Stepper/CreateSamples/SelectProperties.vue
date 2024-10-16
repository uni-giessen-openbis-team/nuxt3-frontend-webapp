

<script setup lang="ts">
import { ref } from 'vue';
import type { Property } from '@/types/wizard'

const selectedProperties = ref<Property[] | null>(null);

const props = defineProps<{
  properties: Array<Property>; // Adjust the type as necessary
}>()

const emit = defineEmits(['update:selectedProperties']);

const _selectedProperties = computed(() => {
  if (selectedProperties.value) {
    for (const [i, property] of Object.entries(selectedProperties.value)) {
      if  (typeof property === 'string'  ) {
        selectedProperties.value[i] = { title: property };
      }
    }
    return selectedProperties.value;
  }
  return [];
});
  
  
watch(_selectedProperties, (newValue) => {
});


</script>


<template>
  <v-container>
    <v-combobox
      v-model="selectedProperties"
      :items="props.properties"
      label="Select a Property"
      outlined
      multiple
    />
  </v-container>
</template>





