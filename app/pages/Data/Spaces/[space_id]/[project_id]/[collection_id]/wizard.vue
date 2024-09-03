<script setup lang="ts">
import { ref } from 'vue';
import 'vue3-form-wizard/dist/style.css';


const tab = ref('');
const store = useWizardStore();

const route = useRoute()

const spaceId = route.params.space_id as string
const projectId = route.params.project_id as string
const collectionId = route.params.collection_id as string


const  {entityConditionsResult: entetyConditionsResult, entetyAndSampleResult, technicalSamples: result} = storeToRefs(useWizardStore())  

onMounted(async () => {
  // set collection context code
  useWizardStore().collectionContext.code = collectionId as string
  useWizardStore().projectContext.code = projectId as string
  useWizardStore().spaceContext.code = spaceId as string
})


const    e1 = ref<number>(1)

const next = async () => {
  console.log(e1.value)
  switch (e1.value) {
    case 0:
      await store.updateEntityVariables()
      break
    case 1:
      // No function for Entity Preview, just move to next step
      break
    case 2:
      await store.updateBiologicalVariables()
      break
    case 3:
      // No function for Biological Samples Preview, just move to next step
      break
    case 4:
      await store.updateTechnicalVariables()
      break
    case 5:
      // Final step, call onComplete
      await store.onComplete()
      return // Don't increment e1 after completion
  }
  e1.value++
}

const prev = () => {
  e1.value--
}
</script>
 


<template>


  <v-container>


  <h2>
    Create new samples for collection {{collectionId}}
  </h2>
  <br>
    <v-tabs
      v-model="tab"
      fixed-tabs
    >
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
        <v-stepper-item 
          value="1"
          title="Project Enteties"
        />
        <v-divider/>
        <v-stepper-item 
          value="2"
          title="Entety Preview"
        />
        <v-divider/>
        <v-stepper-item 
          value="3"
          title="Biological Samples"
        />
        <v-divider/>
        <v-stepper-item 
          value="4"
          title="Biological Samples Preview"
        />
        <v-divider/>
        <v-stepper-item 
          value="5"
          title="Technical Samples"
        />
        <v-divider/>
        <v-stepper-item 
          value="6"
          title="Technical Samples Preview"
        />
      </v-stepper-header>

      <v-stepper-window>
        <v-stepper-window-item value="1">
          <WizardProjectEnteties v-model="store.entityVariables"/>
        </v-stepper-window-item>

        <v-stepper-window-item value="2">
          <WizardPreviewTable v-model="entetyConditionsResult" /> 
        </v-stepper-window-item>

        <v-stepper-window-item value="3">
          <WizardSampleExtracts v-model="store.sampleVariables" />
        </v-stepper-window-item>

        <v-stepper-window-item value="4">
          <WizardPreviewTable v-model="entetyAndSampleResult" />
        </v-stepper-window-item>

        <v-stepper-window-item value="5">
          <WizardTechnical v-model="store.technicalVariables" />
        </v-stepper-window-item>

        <v-stepper-window-item value="6">
          <WizardPreviewTable v-model="result" />
        </v-stepper-window-item>
      </v-stepper-window>
    
      <v-stepper-actions
        @click:next="next"
        @click:prev="prev"
      >
        <template #next>
          <v-btn v-if="e1 < 5" color="primary" @click="next">Next</v-btn>
          <v-btn v-else color="success" :disabled="false" @click="store.onComplete()">Finish</v-btn>
        </template>
        <template #prev>
          <v-btn  @click="prev">Prev</v-btn>
        </template>
      </v-stepper-actions>
    </v-stepper>
      </v-window-item>
      <v-window-item :key="2" value="Upload">
        <v-form>
          <v-file-input
          
            label="File input"
            multiple
            chips
            clearable
            hint="Select one or more files"
            persistent-hint
          />
        </v-form>
      </v-window-item>
    </v-window>

  </v-container>
</template>