<script setup lang="ts">
import 'vue3-form-wizard/dist/style.css';
import type { Sample, Property } from '~/types/wizard';
import { propertyWithVocabulary, propertyWithoutVocabulary } from './testData';

const entetyProperties: Property[] = [
  propertyWithVocabulary,
  propertyWithoutVocabulary
]

// Define props
const props = defineProps<{
  entitySamples?: Sample[],
  biologicalSamples?: Sample[],
}>()

const emit = defineEmits<{
  (e: 'entityVariablesUpdated' | 'biologicalVariablesUpdated' | 'technicalVariablesUpdated', variables: Sample[]): void,
  (e: 'completed'): void
}>()

// control the stepper
const e1 = ref<number>(0)

const next = async () => {
  console.log(e1.value)
  switch (e1.value) {
    case 0:
      // emit('entityVariablesUpdated',props.entityVariables); 
      break
    case 1:
      // No function for Entity Preview, just move to next step
      break
    case 2:
      // emit('biologicalVariablesUpdated',  props.biologicalVariables); 
      break
    case 3:
      // No function for Biological Samples Preview, just move to next step
      break
    case 4:
      // emit('technicalVariablesUpdated', props.technicalVariables); 
      break
    case 5:
      // emit('completed');
      return 
  }
  e1.value++
} 

const prev = () => {
  e1.value--
}


const _entitySamples: Sample[] = props.entitySamples || [] // Can be passed as props, to act as already created samples
const _biologicalSamples: Sample[] = props.biologicalSamples || [] // Can be passed as props, to act as already created samples
const _technicalSamples: Sample[] =  [] // They are always empty because the need to be created in the wizard


let currentScenario:string = ''

if (_entitySamples.length === 0 && _biologicalSamples.length === 0 && _technicalSamples.length === 0) {
  console.log('No samples passed as props');
  currentScenario = 'No samples passed as props';
  e1.value = 0; // Start from the beginning
} else if (_biologicalSamples.length > 0) {
  console.log('Biological samples passed as props');
  currentScenario = 'Biological samples passed as props';
  e1.value = 2; // Start from creating technical samples
} else if (_entitySamples.length > 0) {
  console.log('Enteties passed as props');
  currentScenario= 'Enteties passed as props';
  e1.value = 1; // Start from creating biological samples
}
 
</script>

<template>
  <div v-if="currentScenario !== ''">
    No Data Passed as props, go through the whole wizard to create samples.
  </div>
  <v-stepper v-model="e1" alt-labels>
    <v-stepper-header>
      <v-stepper-item value="1" title="Project Enteties" />
      <v-divider />
      <v-stepper-item value="2" title="Entety Preview" />
      <v-divider />
      <v-stepper-item value="3" title="Biological Samples" />
      <v-divider />
      <v-stepper-item value="4" title="Biological Samples Preview" />
      <v-divider />
      <v-stepper-item value="5" title="Technical Samples" />
      <v-divider />
      <v-stepper-item value="6" title="Technical Samples Preview" />
    </v-stepper-header>

    <v-stepper-window>
      <v-stepper-window-item value="1">
        <WizardStepperCreateSamples 
          :properties="entetyProperties"
          @update:return-samples="(updatedList) => { _entitySamples = updatedList; }" 
        />
      </v-stepper-window-item>

      <v-stepper-window-item value="2">
        <WizardStepperShowSamplesPreviewSamples :samples="_entitySamples" />
      </v-stepper-window-item>

      <v-stepper-window-item value="3">
        <!-- <WizardSampleExtracts v-model="store.sampleVariables" /> -->
      </v-stepper-window-item>

      <v-stepper-window-item value="4">
        <!-- <WizardPreviewTable v-model="entetyAndSampleResult" /> -->
      </v-stepper-window-item>

      <v-stepper-window-item value="5">
        <!-- <WizardTechnical v-model="store.technicalVariables" /> -->
      </v-stepper-window-item>

      <v-stepper-window-item value="6">
        <!-- <WizardPreviewTable v-model="result" /> -->
      </v-stepper-window-item>
    </v-stepper-window>

    <v-stepper-actions @click:next="next" @click:prev="prev">
      <template #next>
        <v-btn v-if="e1 < 5" color="primary" @click="next">Next</v-btn>
        <v-btn v-else color="success" :disabled="false" @click="emit('completed')">Finish</v-btn>
      </template>
      <template #prev>
        <v-btn @click="prev">Prev</v-btn>
      </template>
    </v-stepper-actions>
  </v-stepper>
</template>
