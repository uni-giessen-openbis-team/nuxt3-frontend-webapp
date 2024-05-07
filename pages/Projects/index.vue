<script setup lang = 'ts'>
import { ref } from 'vue'
import { FormWizard, TabContent } from 'vue3-form-wizard'
import type { TableVariable } from '@/types/wizzard'
import type { ProjectContext } from '@/components/Wizzard/ProjectContext.vue'
import { createTableEntries, crossProductSamples } from '@/composables/utils'

import 'vue3-form-wizard/dist/style.css'

const tab = ref('')
const store = useOpenBisStore()
const Entry = {
  conditions: [] as (string | number)[],
  continous: false,
  unit: null,
  identifier: '' as string,
}

// Project Context
const projectContext = ref<ProjectContext>({
  UUID: '',
  name: '',
  space: '',
  description: '',
  manager: '',
  contactPerson: '',
})

// Entety
const speciesEntry: TableVariable = {
  ...Entry,
  title: 'species',
}

const entetyVariables = ref([speciesEntry])
const tempEntetyVariables = ref([])
const entetyConditionsResult = ref([])

function updateEntety() {
  const SAMPLE_TYPE = 'BIOLOGICAL_ENTITY'
  const isEqual = tempEntetyVariables.value == JSON.stringify(entetyVariables.value)
  if (!isEqual) {
    entetyConditionsResult.value = createTableEntries(entetyVariables.value, SAMPLE_TYPE)
    tempEntetyVariables.value = JSON.stringify(entetyVariables.value)
  }
  return true
}

// Biol Sample
const tissueEntry: TableVariable = {
  ...Entry,
  title: 'tissue',
}

const sampleVariables = ref([tissueEntry])
const tempSampleVariables = ref([])
const sampleConditionsResult = ref([])
const entetyAndSampleResult = ref([])

function updateBiol() {
  const SAMPLE_TYPE = 'BIOLOGICAL_SAMPLE'
  const isEqual = tempSampleVariables.value == JSON.stringify(sampleVariables.value)
  if (!isEqual) {
    sampleConditionsResult.value = createTableEntries(sampleVariables.value, SAMPLE_TYPE)
    entetyAndSampleResult.value = crossProductSamples(entetyConditionsResult.value, sampleConditionsResult.value)
    tempSampleVariables.value = JSON.stringify(sampleVariables.value)
  }
  return true
}

// Technical Sample
const methodsEntry: TableVariable = {
  ...Entry,
  title: 'methods',
}
const techVariables = ref([methodsEntry])
const techConditionsResult = ref([])
const tempTechVariables = ref([])
const Result = ref([])
const tmpResult = ref([])

function updateTech() {
  const SAMPLE_TYPE = 'TECHNICAL_SAMPLE'
  const isEqual = tempTechVariables.value == JSON.stringify(techVariables.value)
  if (!isEqual) {
    techConditionsResult.value = createTableEntries(techVariables.value, SAMPLE_TYPE)
    Result.value = crossProductSamples(entetyAndSampleResult.value, techConditionsResult.value)
    tmpResult.value = JSON.stringify(Result.value)
  }
  return true
}

async function onComplete() {
  // The different Samples from chilt to parent
  //  - projectContext
  //  - entetyConditionsResult
  //  - sampleConditionsResult
  //  - techConditionsResult

  await store.createProject(projectContext.value.name, projectContext.value.space, projectContext.value.description)
}
</script>

<template>
  <v-container>
    <v-tabs
      v-model="tab"
      color="deep-purple-accent-4"
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
        <v-form>
          <FormWizard @on-complete="onComplete">
            <TabContent title="Project Context">
              <WizzardProjectContext v-model="projectContext" />
            </TabContent>
            <!-- arrow https://github.com/BinarCode/vue-form-wizard/issues/40 -->
            <TabContent title="Project Enteties" :before-change="() => updateEntety() ">
              <WizzardProjectEnteties v-model="entetyVariables" />
            </TabContent>
            <TabContent title="Entety Preview">
              <WizzardPreviewTable v-model="entetyConditionsResult" />
            </TabContent>
            <TabContent title="Biological Samples" :before-change="() => updateBiol()">
              <WizzardSampleExtracts v-model="sampleVariables" />
            </TabContent>
            <TabContent title="Biological Samples Preview">
              <WizzardPreviewTable v-model="entetyAndSampleResult" />
            </TabContent>
            <TabContent title="Technical Samples" :before-change="() => updateTech()">
              <WizzardTechnical v-model="techVariables" />
            </TabContent>
            <TabContent title="Technical Samples Preview">
              <WizzardPreviewTable v-model="Result" />
            </TabContent>
            <TabContent title="final Form" />
          </FormWizard>
        </v-form>
      </v-window-item>
      <v-window-item :key="2" value="Upload">
        <v-form>
          <v-file-input
            v-model="files"
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
    <pre>
    {{ projectContext }}
   {{ entetyConditionsResult }}
   {{ sampleConditionsResult }}
   {{ techConditionsResult }}
    </pre>
  </v-container>
</template>
