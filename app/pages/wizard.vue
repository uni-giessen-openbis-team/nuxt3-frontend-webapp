<script setup lang="ts">
import WizardSelectEnteties from '~/components/Wizard/SelectEntities.vue';
import WizardPreviewTable from '~/components/Wizard/PreviewTable.vue';
import { useWizardStore } from '~/composables/wizardStore';

const wizardStore = useWizardStore();

// Ensure that createSampleHandlers is called only once, possibly in a setup or lifecycle hook
wizardStore.createSampleHandlers();

const { spaceId, projectId, collectionId } = storeToRefs(wizardStore);

const entitySampleHandler = ref(new EntitySampleHandler(spaceId.value, projectId.value, "1"));
const biologicalSampleHandler = ref(new BiologicalSampleHandler(spaceId.value, projectId.value, "1", entitySampleHandler.value));
const technicalSampleHandler = ref(new TechnicalSampleHandler(spaceId.value, projectId.value, "1", biologicalSampleHandler.value));


const tab = ref('');
const e1 = ref<number>(0);

async function onComplete() {
  await entitySampleHandler.value?.createSamples();
  await biologicalSampleHandler.value?.createSamples();
  await technicalSampleHandler.value?.createSamples();
}

const steps = [
  { id: 0, title: "Project Entities" },
  { id: 1, title: "Entity Preview" },
  { id: 2, title: "Biological Samples" },
  { id: 3, title: "Biological Samples Preview" },
  { id: 4, title: "Technical Samples" },
  { id: 5, title: "Technical Samples Preview" },
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
    case 3:
      // No function for Biological Preview, just move to next step
      break;
    case 4:
      await technicalSampleHandler.value?.createSampleCreations();
      break;
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
    {{ useRoute().query }}

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

          <div v-if="entitySampleHandler && biologicalSampleHandler && technicalSampleHandler">
            <v-stepper-window>
              <v-stepper-window-item v-if="e1 === 0" :value="0">
                <WizardSelectEnteties v-model="entitySampleHandler.properties" :items="entitySampleHandler.items" />
              </v-stepper-window-item>
              <v-stepper-window-item v-if="e1 === 1" :value="1">
                <WizardPreviewTable v-model="entitySampleHandler.sampleCreations" />
              </v-stepper-window-item>
              <v-stepper-window-item v-if="e1 === 2" :value="2">
                <WizardSelectEnteties v-model="biologicalSampleHandler.properties"
                  :items="biologicalSampleHandler.items" />
              </v-stepper-window-item>
              <v-stepper-window-item v-if="e1 === 3" :value="3">
                <WizardPreviewTable v-model="biologicalSampleHandler.sampleCreations" />
              </v-stepper-window-item>
              <v-stepper-window-item v-if="e1 === 4" :value="4">
                <WizardSelectEnteties v-model="technicalSampleHandler.properties"
                  :items="technicalSampleHandler.items" />
              </v-stepper-window-item>
              <v-stepper-window-item v-if="e1 === 5" :value="5">
                <WizardPreviewTable v-model="technicalSampleHandler.sampleCreations" />
              </v-stepper-window-item>
            </v-stepper-window>
          </div>
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