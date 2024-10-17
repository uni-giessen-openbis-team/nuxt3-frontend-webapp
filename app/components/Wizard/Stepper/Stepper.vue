<script setup lang="ts">
import { FormWizard, TabContent } from 'vue3-form-wizard';
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

const _enetySamples: Ref<Sample[]> = ref(props.entitySamples ?? [])
const _biologicalSamples: Ref<Sample[]> = ref(props.biologicalSamples ?? [])

const updateSamples = (samples: Sample[]) => {
  _enetySamples.value = samples;
}


</script>

<template>
    <FormWizard @on-complete="() => { emit('completed') }">
            
      <TabContent title="Project Entities">
        <WizardStepperCreateSamples :properties="entetyProperties" @return-samples="updateSamples, $event" />

      </TabContent>
      
      <TabContent title="Project Entities Preview" :before-change="() => emit('entityVariablesUpdated', _enetySamples)">
        {{_enetySamples}}
        <WizardStepperShowSamplesPreviewSamples :samples="_enetySamples" />
      </TabContent>
      <!-- <TabContent
        title="Entity Preview"
        :before-change="() => emit('entityVariablesUpdated', _enetySamples)"
      >
    </TabContent>  -->
        <!-- <WizardPreviewTable v-model="entetyConditionsResult" />
      </TabContent>
      <TabContent title="Biological Samples" :before-change="store.updateBiologicalVariables">
        <WizardSampleExtracts v-model="store.sampleVariables" />
      </TabContent> 
      <TabContent title="Biological Samples Preview">
        <WizardPreviewTable v-model="entetyAndSampleResult" />
      </TabContent>
      <TabContent title="Technical Samples" :before-change="store.updateTechnicalVariables">
        <WizardTechnical v-model="store.technicalVariables" />
      </TabContent>
      <TabContent title="Technical Samples Preview">
        <WizardPreviewTable v-model="result" />
        -->

   </FormWizard>
</template>


<style scoped>


</style>
