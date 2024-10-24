<script setup lang="ts">
import { FormWizard, TabContent } from 'vue3-form-wizard';
import 'vue3-form-wizard/dist/style.css';
import type { Sample, Property, Pool } from '~/types/wizard';
import { propertyWithVocabulary, propertyWithoutVocabulary } from './testData';

// Define props
const props = defineProps<{
  entitySamples?: Sample[],
  biologicalSamples?: Sample[],

}>()

const emit = defineEmits<{
  (e: 'updateSamples', samples: { entitySamples: Sample[], biologicalSamples: Sample[], technicalSamples: Sample[] }): void,
}>()

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

const _enetySamples: Ref<Sample[]> = ref(props.entitySamples ?? [])
const _enetyPoolSamples = ref<Pool[]>([]);

const _biologicalSamples: Ref<Sample[]> = ref(props.biologicalSamples ?? [])
const _biologicalPoolSamples = ref<Pool[]>([]);

const _technicalSamples: Ref<Sample[]> = ref([])
const _technicalPoolSamples = ref<Pool[]>([]);


function createPoolSamples(pools: Pool[]): Sample[] {
  if (pools.length === 0 || pools.every(pool => pool.samples.length === 0)) {
    return []; // Return an empty array if no pools exist or if no samples are in any of the pools
  }
  const samples: Sample[] = [];
  for (const pool of pools) {
    samples.push({
      name: pool.name,
      conditions: pool.samples.flatMap(sample => sample.conditions), // Unpack and combine conditions
      externalDBID: pool.name,
      Id: pool.id.toString(),
      count: 1,
      parent: pool.samples.map(sample => sample.Id)
    });
  }
  return samples;
}


</script>

<template>
  <FormWizard 
    @on-complete="() => { emit('updateSamples', { technicalSamples: _technicalSamples, entitySamples: _enetySamples, biologicalSamples: _biologicalSamples }) }">
    
    <div v-if="!props.entitySamples">
      <!-- Entities -->
       <!--  :before-change="updateEntityVariables" -->
      <TabContent  title="Project Entities" > 
        <WizardStepperCreateSamples
          :properties="entetyProperties"
          @update-samples="(samples: Sample[]) => { _enetySamples = samples; }" />
      </TabContent>

      <TabContent title="Project Entities Preview">
        <WizardStepperShowSamplesPreviewSamples :samples="_enetySamples" /> 
      </TabContent>

      <TabContent   title="Pool Samples">
        <WizardStepperPoolSamples :samples="_enetySamples" @update-samples="(poolSamples: Sample[]) => { _enetyPoolSamples = poolSamples; }" />
      </TabContent>
    </div>

    <!-- Biological -->
    <div v-if="!props.biologicalSamples">
      <TabContent title="Entity Preview" >
        <WizardStepperCreateSamples
          v-model:samples="_biologicalSamples"  
          :properties="biologicalProperties"
          :parent-samples="_enetySamples"
        />
      </TabContent>

      <TabContent title="Project Entities Preview">
        <WizardStepperShowSamplesPreviewSamples :samples="_biologicalSamples" />
      </TabContent>

      <TabContent  title="Pool Samples">
        <WizardStepperPoolSamples :samples="_biologicalSamples" />
      </TabContent>
    </div>

    <!-- Technical -->
    <TabContent title="Technical Samples">
      <WizardStepperCreateSamples
        :properties="technicalProperties" :parent-samples="_biologicalSamples"
        @update-samples="(samples: Sample[]) => { _technicalSamples = samples; }" />
    </TabContent>

    <TabContent title="Project Entities Preview">
      <WizardStepperShowSamplesPreviewSamples :samples="_technicalSamples" />
    </TabContent>

    <TabContent  title="Pool Samples"> 
      <WizardStepperPoolSamples :samples="_technicalSamples" />
    </TabContent>
  </FormWizard>
</template>

<style scoped>  

</style>
