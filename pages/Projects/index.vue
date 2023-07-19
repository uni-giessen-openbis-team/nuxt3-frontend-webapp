<script setup lang = 'ts'>
import { ref } from 'vue'
import { FormWizard, TabContent } from 'vue3-form-wizard'
import type { TableVariable } from 'types/wizzard'
import type { ProjectContext } from 'components/Wizzard/ProjectContext.vue'
import { createCombinations } from '@/composables/utils'
import { useOpenBisStore } from '@/composables/openbisAPI'

import 'vue3-form-wizard/dist/style.css'

const tab = ref('')
const store = useOpenBisStore()
const Entry = {
  sampleType: '' as string,
  conditions: [] as (string | number)[],
  continous: false,
  unit: null,
  identifier: '' as string,
}
const speciesEntry: TableVariable = {
  ...Entry,
  title: 'species',
}

const tissueEntry: TableVariable = {
  ...Entry,
  title: 'tissue',
}

const projectContext = ref<ProjectContext>({
  name: '',
  space: '',
  description: '',
  manager: '',
  contactPerson: '',
})

const entetyVariables = ref([speciesEntry])
const tempEntetyVariables = ref([])
const entetyConditionsResult = ref([])

const sampleVariables = ref([tissueEntry])
const tempSampleVariables = ref([])
const combinedVariables = ref([])
const sampleConditionsResult = ref({})

async function onComplete() {
  test.value = await store.createProject(projectContext.value.name, projectContext.value.space, projectContext.value.description)
  alert(`Project Created: ${test.value}`)
  // for (const entetyCondition of entetyConditionsResult.value)
  //   createSampleEntry({EXPERIMENT: "experiemtn_number", objectCode: entetyCondition.secondaryName, spaceId: projectContext.value.space, collectionId: projectContext.value.name, "Q_BIOLOGICAL_ENTITY" })
  // for (const entryCondition of sampleConditinResult.value )
  //   createSampleEntry("Q_BIOLOGICAL_SAMPLE")
  // for (const entetyCondition of testSampleResult.value)
  // Q_TEST_SAMPLE
}

async function updateEntetyConditionsResult() {
  // if entetyVariables has changed, createCombinations
  const SAMPLE_TYPE = 'Q_BIOLOGICAL_ENTITY'

  const isEqual = tempEntetyVariables.value == JSON.stringify(entetyVariables.value)
  if (!isEqual) {
    console.log('Creating combinations')
    entetyConditionsResult.value = await createCombinations(entetyVariables.value, SAMPLE_TYPE)

    tempEntetyVariables.value = JSON.stringify(entetyVariables.value)
  }
  else {
    console.log('Variables did not change')
  }
  return true
}

async function updateSampleConditionsResult() {
  const SAMPLE_TYPE = 'Q_BIOLOGICAL_SAMPLE'

  const combinedVariablesNew = sampleVariables.value.concat(entetyVariables.value)
  const isEqual = combinedVariables.value === JSON.stringify(combinedVariablesNew)

  if (!isEqual) {
    console.log('Creating combinations')
    combinedVariables.value = combinedVariablesNew
    sampleConditionsResult.value = await createCombinations(sampleVariables.value, SAMPLE_TYPE)
    tempSampleVariables.value = JSON.stringify(sampleVariables.value)
  }
  else {
    console.log('Variables did not change')
  }

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
          <FormWizard @on-complete="onComplete">
            <TabContent title="Project Context">
              <WizzardProjectContext v-model="projectContext" />
            </TabContent>
            <!-- arrow https://github.com/BinarCode/vue-form-wizard/issues/40 -->
            <TabContent title="Project Enteties" :before-change="() => updateEntetyConditionsResult() ">
              <WizzardProjectEnteties v-model="entetyVariables" />
            </TabContent>
            <TabContent title="Samples Preview">
              <WizzardPreviewTable v-model="entetyConditionsResult" />
            </TabContent>
            <TabContent title="Project Samples" :before-change="() => updateSampleConditionsResult()">
              <WizzardSampleExtracts v-model="sampleVariables" />
            </TabContent>
            <!-- Use the function inside here -->
            <!-- Combine  projectEnteties and projectSamples and create sampleConditinCombinatinos -->
            <!-- <TabContent title="Samples Preview">
              <WizzardPreviewTable v-model="entetyConditionCombinations" />
            </TabContent> -->

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
  </v-container>
  <h3>conditionsResult</h3>
  <pre> {{ entetyConditionsResult }}</pre>
  <h3>variables</h3>
  <pre> {{ entetyVariables }}</pre>
  <h3>tempVariables</h3>
  <pre>{{ tempEntetyVariables }}</pre>
</template>
