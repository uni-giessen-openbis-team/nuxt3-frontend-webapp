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

const technicalProperties: Property[] = [
  propertyWithVocabulary,
  propertyWithoutVocabulary
]

// Define props
const props = defineProps<{
  entitySamples?: Sample[],
  biologicalSamples?: Sample[],

}>()

const emit = defineEmits<{
  (e: 'samplesUpdated' , variables: Array<Sample[]>): void,
  (e: 'completed',  technicalSamples: Sample[] , entitySamples?: Sample[], biologicalSamples?: Sample[]): void
}>()

const _enetySamples: Ref<Sample[]> = ref(props.entitySamples ?? [])
const _biologicalSamples: Ref<Sample[]> = ref(props.biologicalSamples ?? [])
const _technicalSamples: Ref<Sample[]> = ref( [])

</script>

<template> 
  <FormWizard @on-complete="() => { emit('completed',  _technicalSamples, _enetySamples, _biologicalSamples,) }">
    <div v-if="!props.entitySamples">
      <TabContent title="Project Entities" >
        <WizardStepperCreateSamples
:properties="entetyProperties"
          @return-samples="(samples) => { _enetySamples = samples; }" />
      </TabContent>
      <TabContent title="Project Entities Preview">
        <WizardStepperShowSamplesPreviewSamples :samples="_enetySamples" />
      </TabContent>
    </div>

    <div v-if="!props.biologicalSamples">
      <TabContent title="Entity Preview">
        <WizardStepperCreateSamples
:properties="biologicalProperties" :parent-samples="_enetySamples"
          @return-samples="(samples) => { _biologicalSamples = samples; }" />
      </TabContent>
      <TabContent title="Project Entities Preview">
        <WizardStepperShowSamplesPreviewSamples :samples="_biologicalSamples" />
      </TabContent>
    </div>

    <TabContent title="Technical Samples">
        <WizardStepperCreateSamples
  :properties="technicalProperties" :parent-samples="_biologicalSamples"
          @return-samples="(samples) => { _biologicalSamples = samples; }" />
      </TabContent>
      <TabContent title="Project Entities Preview">
        <WizardStepperShowSamplesPreviewSamples :samples="_technicalSamples" />
      </TabContent>
  </FormWizard>
</template>
