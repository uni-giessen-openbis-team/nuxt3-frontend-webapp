<script setup lang="ts">
import { FormWizard, TabContent } from 'vue3-form-wizard';
import 'vue3-form-wizard/dist/style.css';
import type { Sample, Property } from '~/types/wizard';
import { propertyWithVocabulary, propertyWithoutVocabulary } from './testData';
import { createPoolSamples } from './CreateSamples/utils';

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

const entitySamples = ref<Sample[]>(props.entitySamples ?? [])
const biologicalSamples = ref<Sample[]>(props.biologicalSamples ?? [])
const technicalSamples = ref<Sample[]>([])

function completed() {
  const entityPoolSamples = createPoolSamples(entitySamples.value)
  entitySamples.value = [...entityPoolSamples, ...entitySamples.value]
  const biologicalPoolSamples = createPoolSamples(biologicalSamples.value)
  biologicalSamples.value = [...biologicalPoolSamples, ...biologicalSamples.value]
  const technicalPoolSamples = createPoolSamples(technicalSamples.value)
  technicalSamples.value = [...technicalPoolSamples, ...technicalSamples.value]

  emit('updateSamples', { technicalSamples: technicalSamples.value, entitySamples: entitySamples.value, biologicalSamples: biologicalSamples.value }) 
}
 
</script>

<template>
  <FormWizard 
    @on-complete="completed">
    
    <div v-if="!props.entitySamples">
      <!-- Entities -->
       <!--  :before-change="updateEntityVariables" -->
      <TabContent  title="Project Entities" > 
        <WizardStepperCreateSamples
          :properties="entetyProperties"
          @update-samples="(samples: Sample[]) => { entitySamples = samples; }" />
      </TabContent>

      <TabContent title="Project Entities Preview">
        <WizardStepperShowSamplesPreviewSamples
          v-model:samples="entitySamples" />
      </TabContent>
    

      <TabContent   title="Pool Samples">
        <WizardStepperPoolSamples 
          v-model:samples="entitySamples"
        />
      </TabContent>
    </div>

    <!-- Biological -->
    <div v-if="!props.biologicalSamples">
      <TabContent title="Entity Preview" >
        <WizardStepperCreateSamples
          :properties="biologicalProperties"
          :parent-samples="entitySamples" @update-samples="(samples: Sample[]) => { biologicalSamples = samples; }"/>
      </TabContent>

      <TabContent title="Project Entities Preview">
        <WizardStepperShowSamplesPreviewSamples v-model:samples="biologicalSamples" />
      </TabContent>

      <TabContent  title="Pool Samples">
        <WizardStepperPoolSamples v-model:samples="biologicalSamples" />
      </TabContent>
    </div>

    <!-- Technical -->
    <TabContent title="Entity Preview" >
        <WizardStepperCreateSamples
          :properties="technicalProperties"
          :parent-samples="biologicalSamples" @update-samples="(samples: Sample[]) => { technicalSamples = samples; }"/>
      </TabContent>

    <TabContent title="Project Entities Preview">
      <WizardStepperShowSamplesPreviewSamples v-model:samples="technicalSamples" />
    </TabContent>

    <TabContent  title="Pool Samples"> 
      <WizardStepperPoolSamples v-model:samples="technicalSamples" />
    </TabContent>
  </FormWizard>
</template>


