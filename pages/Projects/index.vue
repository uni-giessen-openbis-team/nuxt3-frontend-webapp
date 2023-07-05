<script setup>
import { ref } from 'vue'
import { FormWizard, TabContent } from 'vue3-form-wizard'
import 'vue3-form-wizard/dist/style.css'

const tab = ref('')
const projectContext = ref({})
const projectSamples = ref({
  tableVariables: ref([
    {
      title: 'species',
      conditions: ref([]),
      continous: false,
      unit: null,
    },
  ]),
})

const submitForm = () => {
  formOutput.value = JSON.stringify(form, null, 2) // The stringify function arguments provide a pretty print format
}

// form wizzard functions
// export function isValid() {
//   if (projectContext.value.space === '' || projectContext.value.name === ''
//     || projectContext.value.description === '' || length(projectContext.value.description) < MINDESCLENGTH
//   ) {
//     return true// TODO: Returning true will prevent the user from moving to the next tab
//     alert('Please enter a project context')
//   }
//   return true
// }

function onComplete() {
  alert('Yay. Done!')
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
            <TabContent title="Project Samples">
              <WizzardProjectSamples v-model="projectSamples" />
            </TabContent>
            <TabContent title="final Form">
              Yuhuuu! This seems pretty damn simple
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
      <div>
        Sample Preview
      </div>
    </v-window>
  </v-container>
</template>
