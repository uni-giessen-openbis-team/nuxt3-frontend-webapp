<script setup>
import { ref } from 'vue'
import { FormWizard, TabContent } from 'vue3-form-wizard'
import 'vue3-form-wizard/dist/style.css'

const tab = ref('')
const test = true
const MINDESCLENGTH = 20 // Minimum length of the description field

const projectContext = ref({})

// sampleSources
const variablespeciesNumber = ref(1)
const tableSpecies = ref([])
const tableVariables = ref([{
  title: 'species',
}])

const variables = ref([
  { title: 'genotype' }, { title: 'color' },
])

const DATABASE_SPECIES = ['species1', 'species2']

// List of default variables

const submitForm = () => {
  formOutput.value = JSON.stringify(form, null, 2) // The stringify function arguments provide a pretty print format
}

// form wizzard functions
function checkProjectContext() {
  if (projectContext.value.space === '' || projectContext.value.name === ''
    || projectContext.value.description === '' || length(projectContext.value.description) < MINDESCLENGTH
  ) {
    return test // TODO: Returning true will prevent the user from moving to the next tab
    alert('Please enter a project context')
  }
  return true
}

function onComplete() {
  alert('Yay. Done!')
}

watch(tableVariables, (newValue, oldValue) => {
  for (let i = 0; i < newValue.length; i++) {
    // Check if the condition property exists, if not, initialize it
    if (!newValue[i].hasOwnProperty('condition'))
      newValue[i].condition = []
  }
})
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
            <TabContent title="Project Context" :before-change="checkProjectContext">
              <WizzardProjectContext

                @update:modelValue="val => projectContext = val"
              />
            </TabContent>

            <TabContent title="Sample Sources">
              <v-autocomplete
                v-model="tableVariables"
                label="Experimental variables"
                box
                chips
                :items="variables"
                multiple
                return-object
              />
              <div>
                <v-card>
                  <v-tabs v-model="tab" bg-color="primary">
                    <v-tab v-for="(item, index) in tableVariables" :key="index" :value="item.title">
                      {{ item.title }}
                    </v-tab>
                  </v-tabs>
                  <v-card-text>
                    <v-window v-model="tab">
                      <v-window-item v-for="(item, index) in tableVariables" :key="index" :value="item.title">
                        <!-- if species, create a species selector -->
                        <div v-if="item.title === 'species'">
                          How many different species are there in this project?
                          <v-text-field
                            v-model="variablespeciesNumber"
                            type="number"
                            label="Number of species"
                          />
                        </div>

                        <div v-if="item.title === 'species' && variablespeciesNumber">
                          <div v-for="(n) in Number(variablespeciesNumber)" :key="n">
                            Species {{ n }}
                            <v-text-field v-model="tableSpecies[n]" />
                          </div>
                        </div>
                        <div v-else>
                          {{ item.title }} content test
                          <TablesCrudTable v-model="item.condition" />
                        </div>
                      </v-window-item>
                    </v-window>
                  </v-card-text>
                </v-card>
              </div>
            </TabContent>

            <TabContent title="final Form" step="1">
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

        <!-- Next Page for every  Experimental Variable different occurences -->
        <h1>Biol. Variables</h1>
        <!-- for every selected experimentalVariable create a tab with a textflield and a radio group with continious and categorical -->
      </v-window-item>
    </v-window>
  </v-container>
  Species
  <pre>{{ tableSpecies }}</pre>
  Variables
  <pre>{{ tableVariables }}</pre>
</template>
