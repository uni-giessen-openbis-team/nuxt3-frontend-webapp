<script setup lang="ts">
import { ref } from 'vue'
import SelectProperties from './SelectProperties.vue'
import type { Property , Sample } from '@/types/wizard'
import TextareaToList from './TextareaToList.vue'
import AddUnitToProperty from './AddUnitToProperty.vue'
import AutocompleteVocabulary from '@/components/Atoms/Autocomplete/Vocabulary.vue'
// This is some small view component, where the selectedProperties are created. and later passed to the parent

const selectedProperties = ref<Property[]>([])

const props = defineProps<{
  items: Array<Property>; // Adjust the type as necessary
}>()


const emit = defineEmits<{
  (e: 'update:return-samples', updatedList: Sample[]): void
}>()

const tab = ref(1)

function calculateCrossProduct(properties: Property[]): Sample[] {
  const crossProduct: Sample[] = [];

  // Assuming each property has a 'conditions' array, and we want to calculate
  // the cross-product of these conditions across all properties.
  const conditionsArrays = properties.map(property => property.conditions || []);

  // Helper function to calculate the cartesian product of arrays
  function cartesianProduct<T>(arrays: T[][]): T[][] {
    return arrays.reduce((a, b) => a.flatMap(d => b.map(e => [...d, e])), [[]] as T[][]);
  }

  const product = cartesianProduct(conditionsArrays);

  // Create new samples based on the cross-product of conditions
  product.forEach(conditionSet => {
    const newSample: Partial<Sample> = {
      conditions: conditionSet,
      secondaryName: '', // Assign appropriate value
      count: '1'
    };
    crossProduct.push(newSample as Sample);
  });

  return crossProduct;
}

function emitCrossProduct() {
  const crossProduct = calculateCrossProduct(selectedProperties.value);
  emit('update:return-samples', crossProduct as Sample[]);
}

function handleSelectedProperties(updatedProperties: Property[]) {
  console.log(updatedProperties); // Log to check if conditions are present
  selectedProperties.value = updatedProperties;
  if (updatedProperties.length > 0) {
    tab.value = updatedProperties[0].title; // Set the tab to the first selected property
  }
  emitCrossProduct();
}

</script>

<template>
<div/>
  <SelectProperties :items="props.items" @update:selected-properties="handleSelectedProperties"/>

  <v-card v-if="selectedProperties.length > 0">
    <v-tabs v-model="tab" bg-color="primary">
      <v-tab v-for="(item, index) in selectedProperties" :key="index" :value="item.title">
        {{ item.title }}
      </v-tab>
    </v-tabs>
    <v-card-text>
      
      <v-window  v-model="tab">
        <v-window-item v-for="(item, index) in selectedProperties" :key="index" :value="item.title">
            <div v-if="item && 'vocabularyCode' in item">
                <div>
                    <AutocompleteVocabulary :search-term="item.vocabularyCode as string"/>
                </div>
            </div>
            <div v-else>
                <TextareaToList @update:list="item.conditions = $event"/>
                <AddUnitToProperty v-model:continuous="item.continuous" v-model:unit="item.unit" />
            </div>
        </v-window-item>
      </v-window>
    </v-card-text>
  </v-card>
</template>

