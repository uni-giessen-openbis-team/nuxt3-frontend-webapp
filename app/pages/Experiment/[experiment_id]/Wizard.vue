<script setup lang="ts">
import { ref } from 'vue';
import 'vue3-form-wizard/dist/style.css';
import type openbis from '~/composables/openbis.esm';
import type { Sample } from '~/types/wizard';
const tab = ref('');

const route = useRoute()
const store = useWizardStore()

const projectContext = {
  experiment_id: route.query.experiment_id as string,
}

const props = defineProps<{
  entitySamples: openbis.Sample[]
  biologicalSamples: openbis.Sample[]
}>()

const _entitySamples = ref<Sample[]>([])
const _biologicalSamples = ref<Sample[]>([])

onMounted(() => {
  store.experimentId = projectContext.experiment_id
  // transform the openbis objects into the format needed for the wizard
  if (props.entitySamples) {

    _entitySamples.value = mapSamplesForWizard(props.entitySamples)
  }
  if (props.biologicalSamples) {
    _biologicalSamples.value = mapSamplesForWizard(props.biologicalSamples)
  }
})

function mapSamplesForWizard(samples: openbis.Sample[]) {
  const _samples: Sample[] = samples.map(sample => ({
    id: sample.getCode(),
    conditions: [],
    externalDBID: sample.getIdentifier().toString(), 
    name: sample.getCode(),
    count: 1, 
    parents: sample.getParents().map(parent => parent.getCode()),
    pools: [] 
  }));
  return _samples;
}



</script>



<template>

  <v-container>

    <h2>
      <!-- Create new samples for collection {{ projectContext.experiment_id }} -->
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
    <br>
    <v-window v-model="tab">
      <v-window-item :key="1" value="Create">
        <WizardStepper @update-samples="(samples) => { }" />
      </v-window-item>
      <v-window-item :key="2" value="Upload">
        <v-form>
          <v-file-input label="File input" multiple chips clearable hint="Select one or more files" persistent-hint />
        </v-form>
      </v-window-item>
    </v-window>
  </v-container>
</template>
