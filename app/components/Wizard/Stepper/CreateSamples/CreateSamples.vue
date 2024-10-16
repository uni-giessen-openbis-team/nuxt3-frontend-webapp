 <script setup lang="ts">
import SelectProperties from './SelectProperties.vue'
import type { Property , Sample  , VocabularyTerm  } from '@/types/wizard'
import TextareaToList from './TextareaToList.vue'
import AddUnitToProperty from './AddUnitToProperty.vue'
// This is some small view component, where the selectedProperties are created. and later passed to the parent

const selectedProperties = ref<Property[]>([])

const props = defineProps<{
  properties: Property[]
}>()

const emit = defineEmits<{
  (e: 'update:return-samples', updatedList: Sample[]): void;
}>();

const tab = ref(1)

function calculateSamplesFromProperties(properties: Property[]): Sample[] {
  const crossProduct: Sample[] = [];

  const conditionsArrays = properties.map(property => property.conditions || []);

  function cartesianProduct<T>(arrays: T[][]): T[][] {
    return arrays.reduce((a, b) => a.flatMap(d => b.map(e => [...d, e])), [[]] as T[][]);
  }

  const product = cartesianProduct(conditionsArrays);

  product.forEach(conditionSet => {
    const newSample: Partial<Sample> = {
      conditions: conditionSet.map(condition => ({
        propertyTitle: condition.title,
        conditionTitle: condition.title
      })),
      secondaryName: '', // Assign appropriate value
      count: 1
    };
    crossProduct.push(newSample as Sample);
  });

  return crossProduct;
}

function emitCrossProduct() {
  const crossProduct = calculateSamplesFromProperties(selectedProperties.value);
  emit('update:return-samples', crossProduct as Sample[]);
}

function handleSelectedProperties(updatedProperties: Property[]) {
  selectedProperties.value = updatedProperties;
  if (updatedProperties.length > 0) {
    tab.value = 0; // Set the tab to the first selected property
  }
}

const updatedProperties = ref<Property[]>([]);

// Deep watcher to run handleSelectedProperties whenever updatedProperties changes deeply
watch(updatedProperties, (newProperties) => {
  handleSelectedProperties(newProperties);
}, { deep: true }); 


const selectedVocabularyTerms = ref<VocabularyTerm[]>([])

// when the selectedVocabulary changes, we need to update the conditions
watch(selectedVocabularyTerms, (newVocabulary) => {
  console.log('selectedVocabulary', newVocabulary)
})

</script>

<template>
<div/>
  <SelectProperties :properties="props.properties" @update:selected-properties="handleSelectedProperties"/>

  <v-card v-if="selectedProperties.length > 0">
    <v-tabs v-model="tab" bg-color="primary">
      <v-tab v-for="(item, index) in selectedProperties" :key="index" :value="item.title">
        {{ item.title }}
      </v-tab>
    </v-tabs>
    <v-card-text>
      
      <v-window  v-model="tab">
        <v-window-item v-for="(property, index) in selectedProperties" :key="index" :value="property.title">
            <div v-if="property && 'vocabulary' in property">
                <div>
                    <VSelect
                      v-model="property.conditions" 
                      :items="property.vocabulary.terms" 
                      :return-object="true"
                      multiple 
                  />
                </div>
            </div>
            <div v-else>
                <TextareaToList 
                    @update:list="property.conditions = $event; emitCrossProduct()"
                />
                <AddUnitToProperty 
                    v-model:continuous="property.continuous" 
                    v-model:unit="property.unit" 
                    @input="emitCrossProduct"
                />
            </div>
        </v-window-item>
      </v-window>
    </v-card-text>
  </v-card>
</template>

