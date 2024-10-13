<script setup lang="ts">
import { ref, defineEmits } from 'vue';
import 'vue3-form-wizard/dist/style.css';
import type { Sample } from '~/types/wizard';

const props = defineProps<{
  entitySamples: Sample[], 
  biologicalSamples: Sample[],
  technicalSamples: Sample[] 
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
      emit('entityVariablesUpdated',props.entityVariables); 
      break
    case 1:
      // No function for Entity Preview, just move to next step
      break
    case 2:
      emit('biologicalVariablesUpdated',  props.biologicalVariables); 
      break
    case 3:
      // No function for Biological Samples Preview, just move to next step
      break
    case 4:
      emit('technicalVariablesUpdated', props.technicalVariables); 
      break
    case 5:
      emit('completed');
      return 
  }
  e1.value++
}

const prev = () => {
  e1.value--
}

</script>

<template>
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
        <WizardProjectEnteties v-model="entityVariables" />
      </v-stepper-window-item>

      <v-stepper-window-item value="2">
        <!-- <WizardPreviewTable v-model="entetyConditionsResult" /> -->
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
