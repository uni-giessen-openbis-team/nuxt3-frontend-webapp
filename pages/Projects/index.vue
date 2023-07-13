<script setup lang = 'ts'>
import { ref } from 'vue'
import { FormWizard, TabContent } from 'vue3-form-wizard'
import type { TableVariable } from 'types/wizzard'
import { createCombinations } from '@/composables/utils'

import 'vue3-form-wizard/dist/style.css'
const Entry = {
  conditions: [] as (string | number)[],
  continous: false,
  unit: null,
}

const speciesEntry: TableVariable = {
  ...Entry,
  title: 'species',
}

const tissueEntry: TableVariable = {
  ...Entry,
  title: 'tissue',
}
const tab = ref('')
const projectContext = ref({})
const entetyVariables = ref([speciesEntry])
const sampleVariables = ref([tissueEntry])

const entetyConditionCombinations = ref({})
const sampleConditinCombinatinos = ref({})

const entetyConditionsResult = ref([])

function onComplete() {
  alert('Yay. Done!') 
}

function updateEntetyConditionsResult() {
  console.log(' updateEntetyConditionsResult')
  entetyConditionsResult.value = createCombinations(entetyVariables.value)
  return true
}

function updateSampleConditionsResult() {
  entetyConditionsResult.value = createCombinations(sampleVariables.value)
  return true
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
          <FormWizard>
            <TabContent title="Project Context">
              <WizzardProjectContext v-model="projectContext" />
            </TabContent>
            <TabContent title="Project Enteties" :before-change="updateEntetyConditionsResult">
              <WizzardProjectEnteties v-model="entetyVariables" />
            </TabContent>
            <TabContent title="Samples Preview">
              <WizzardPreviewTable v-model="entetyConditionsResult" />
            </TabContent>
            <TabContent title="Project Samples" :before-change="updateSampleConditionsResult">
              <WizzardSampleExtracts v-model="sampleVariables" />
            </TabContent>
            <!-- Use the function inside here -->
            <!-- Combine  projectEnteties and projectSamples and create sampleConditinCombinatinos -->
            <!-- <TabContent title="Samples Preview">
              <WizzardPreviewTable v-model="entetyConditionCombinations" />
            </TabContent> -->

            <TabContent title="final Form">
              <pre>{{ sampleConditions }}</pre>
            </TabContent>
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
        <v-btn color="primary" @click="submitForm">
          Submit
        </v-btn>
      </v-window-item>
    </v-window>
  </v-container>
</template>
