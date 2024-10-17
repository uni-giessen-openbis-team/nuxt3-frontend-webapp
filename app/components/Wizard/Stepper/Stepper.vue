<script setup lang="ts">
import { FormWizard, TabContent } from 'vue3-form-wizard';
import 'vue3-form-wizard/dist/style.css';
import type { Sample, Property } from '~/types/wizard';
import { propertyWithVocabulary, propertyWithoutVocabulary } from './testData';

const entetyProperties: Property[] = [
  propertyWithVocabulary,
  propertyWithoutVocabulary
]

const biologicalProperties: Property[] = [
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


// function updateEntety() {
//   const SAMPLE_TYPE = 'BIOLOGICAL_ENTITY'
//   const isEqual = tempEntetyVariables.value == JSON.stringify(entetyVariables.value)
//   if (!isEqual) {
//     entetyConditionsResult.value = createTableEntries(entetyVariables.value, SAMPLE_TYPE)
//     tempEntetyVariables.value = JSON.stringify(entetyVariables.value)
//   }
//   return true
// }

// function updateBiol() {
//   const SAMPLE_TYPE = 'BIOLOGICAL_SAMPLE'
//   const isEqual = tempSampleVariables.value == JSON.stringify(sampleVariables.value)
//   if (!isEqual) {
//     sampleConditionsResult.value = createTableEntries(sampleVariables.value, SAMPLE_TYPE)
//     entetyAndSampleResult.value = crossProductSamples(entetyConditionsResult.value, sampleConditionsResult.value)
//     tempSampleVariables.value = JSON.stringify(sampleVariables.value)
//   }
//   return true
// }

// function updateTech() {
//   const SAMPLE_TYPE = 'TECHNICAL_SAMPLE'
//   const isEqual = tempTechVariables.value == JSON.stringify(techVariables.value)
//   if (!isEqual) {
//     techConditionsResult.value = createTableEntries(techVariables.value, SAMPLE_TYPE)
//     Result.value = crossProductSamples(entetyAndSampleResult.value, techConditionsResult.value)
//     tmpResult.value = JSON.stringify(Result.value)
//   }
//   return true
// }


</script>

<template>
  <FormWizard @on-complete="() => { emit('completed') }">
    <div v-if="!props.entitySamples">
      <TabContent title="Project Entities">
        <WizardStepperCreateSamples :properties="entetyProperties"
          @return-samples="(samples) => { _enetySamples = samples; }" />
      </TabContent>

      <TabContent title="Project Entities Preview">
        <WizardStepperShowSamplesPreviewSamples :samples="_enetySamples" />
      </TabContent>
    </div>
    <div v-if="!props.biologicalSamples">
      <TabContent title="Entity Preview">
        <WizardStepperCreateSamples :properties="biologicalProperties" :parent-samples="_enetySamples"
          @return-samples="(samples) => { _biologicalSamples = samples; }" />
      </TabContent>
      <TabContent title="Project Entities Preview">
        <WizardStepperShowSamplesPreviewSamples :samples="_biologicalSamples" />
      </TabContent>
    </div>
    <!-- 

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


<style scoped></style>
