<script setup lang="ts">
import SelectProperties from './SelectProperties.vue'
import type { Property, Sample } from '@/types/wizard'
import TextareaToList from './TextareaToList.vue'
import AddUnitToProperty from './AddUnitToProperty.vue'
import { calculateSamplesFromProperties } from './utils'

const selectedProperties = ref<Property[]>([])

const props = defineProps<{
  properties: Property[]
  parentSamples?: Sample[]
}>()

const emit = defineEmits<{
  (e: 'return-samples', updatedList: Sample[]): void;
}>();

const tab = ref(1)
const newSamples = ref<Sample[]>([])

function createSamples() {
  const crossProduct = calculateSamplesFromProperties(selectedProperties.value);
  
  if (props.parentSamples && props.parentSamples.length > 0) {
    for (const parent of props.parentSamples) {
      for (const child of crossProduct) { 
        const newSample = {
          ...parent,
          conditions: [...parent.conditions, ...child.conditions],
          secondaryName: `${parent.secondaryName}_${child.secondaryName}`
        }
        newSamples.value.push(newSample)
      }
    }
  } else {
    newSamples.value = crossProduct
  }
  emit('return-samples', newSamples.value as Sample[]);
}

function handleSelectedProperties(updatedProperties: Property[]) {
  selectedProperties.value = updatedProperties;
  createSamples();
}

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
      <v-window v-model="tab">
        <v-window-item v-for="(property, index) in selectedProperties" :key="index" :value="property.title">
          <div v-if="property && 'vocabulary' in property">
            <div>
              <VSelect
                v-model="property.conditions" 
                :items="property.vocabulary.terms" 
                :return-object="true"
                multiple 
                @change="createSamples"
              />
            </div>
          </div>
          <div v-else>
            <TextareaToList 
              @update:list="property.conditions = $event; createSamples()"
            />
            <AddUnitToProperty 
              v-model:continuous="property.continuous" 
              v-model:unit="property.unit" 
              @input="createSamples"
            />
          </div>
        </v-window-item>
      </v-window>
    </v-card-text>
  </v-card>
</template>
