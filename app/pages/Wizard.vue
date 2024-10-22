<script setup lang="ts">
import { ref } from 'vue';
import 'vue3-form-wizard/dist/style.css';


const tab = ref('');

const route = useRoute()
const store = useWizardStore()

const projectContext = {
  space_id: route.query.space_id as string,
  project_id: route.query.project_id as string,
  experiment_id: route.query.collection_id as string,
}

const props = defineProps<{
  entitySamples: openbis.Sample[]
  biologicalSamples: openbis.Sample[]
  technicalSamples: openbis.Sample[]
}>()

onMounted(() => {
  store.spaceId = projectContext.space_id
  store.projectId = projectContext.project_id
  store.experimentId = projectContext.experiment_id
})

const entityCreation = prepareSampleCreation( props.entitySamples[0], 'Entity', projectContext.space_id, projectContext.project_id, projectContext.experiment_id )
const biologicalCreation = prepareSampleCreation( props.biologicalSamples[0], 'Biological', projectContext.space_id, projectContext.project_id, projectContext.experiment_id )
const technicalCreation = prepareSampleCreation( props.technicalSamples[0], 'Technical', projectContext.space_id, projectContext.project_id, projectContext.experiment_id )
 
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