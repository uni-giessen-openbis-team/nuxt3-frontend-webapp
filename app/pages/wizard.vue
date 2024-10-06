<script setup lang="ts">
import WizardSelectEnteties from '~/components/Wizard/SelectEntities.vue';
import WizardPreviewTable from '~/components/Wizard/PreviewTable.vue';
import { useWizardStore } from '~/composables/wizardStore';

const wizardStore = useWizardStore();

wizardStore.createSampleHandlers();

const { entitySampleHandler, biologicalSampleHandler, technicalSampleHandler } = storeToRefs(wizardStore);
const { spaceId, projectId,  collectionId } = storeToRefs(wizardStore);

const tab = ref('');
const e1 = ref<number>(0);

async function onComplete() {
  await entitySampleHandler.value?.createSamples();
  await biologicalSampleHandler.value?.createSamples();
  await technicalSampleHandler.value?.createSamples();
}

const steps = [
  { id: 0, title: "Project Entities", component: WizardSelectEnteties, model: entitySampleHandler },
  { id: 1, title: "Entity Preview", component: WizardPreviewTable, model: entitySampleHandler},
  { id: 2, title: "Biological Samples", component: WizardSelectEnteties, model: biologicalSampleHandler },
  { id: 1, title: "Biological Samples Preview", component: WizardPreviewTable, model: biologicalSampleHandler},
  { id: 3, title: "Technical Samples", component: WizardSelectEnteties, model: technicalSampleHandler },
  { id: 4, title: "Technical Samples Preview", component: WizardPreviewTable, model: technicalSampleHandler},
];

const next = async () => {
  const currentStep = steps[e1.value];
  if (!currentStep) return;

  switch (currentStep.id) {
    case 0:
      await entitySampleHandler.value?.createSampleCreations();
      break;
    case 1:
      // No function for Entity Preview, just move to next step
      break;
    case 2:
        await biologicalSampleHandler.value?.createSampleCreations();
      
      break;
    // ... other cases ...
    case 5:
      // Final step, call onComplete
      await onComplete();
      return;
  }
  e1.value++;
};

const prev = () => {
  e1.value--;
};
</script>

<template>
  <v-container>
    {{useRoute().query}}
    
    <h2>
      Create new samples for collection {{ collectionId }}
    </h2>
    <br>
    <v-tabs v-model="tab" fixed-tabs>
      <v-tab value="Create">
        Create
      </v-tab>
      <v-tab value="Upload">
        Upload
      </v-tab>
    </v-tabs>
    <v-window v-model="tab">
      <v-window-item :key="1" value="Create">

        <!-- Vuetify Stepper -->
        <v-stepper v-model="e1" alt-labels>
          <v-stepper-header>
            <template v-for="(step, index) in steps" :key="step.id">
              <v-stepper-item :value="step.id" :title="step.title" />
              <v-divider v-if="index < steps.length - 1" />
            </template>
          </v-stepper-header>

          <v-stepper-window>
            <template v-for="step in steps" :key="step.id">
              <v-stepper-window-item :value="step.id">
                <component :is="step.component" v-model="step.model"  />
              </v-stepper-window-item>
            </template>
          </v-stepper-window>

          <v-stepper-actions @click:next="next()" @click:prev="prev">
            <template #next>
              <v-btn v-if="e1 < steps.length" color="primary" @click="next()">Next</v-btn>
              <v-btn v-else color="success" :disabled="false" @click="onComplete()">Finish</v-btn>
            </template>
            <template #prev>
              <v-btn @click="prev">Prev</v-btn>
            </template>
          </v-stepper-actions>
        </v-stepper>
      </v-window-item>
      <v-window-item :key="2" value="Upload">
        <v-form>
          <v-file-input label="File input" multiple chips clearable hint="Select one or more files" persistent-hint />
        </v-form>
      </v-window-item>
    </v-window>
  </v-container>
</template>