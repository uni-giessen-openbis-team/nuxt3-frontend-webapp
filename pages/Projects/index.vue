<script setup>
import { onMounted, reactive, ref } from 'vue'
import { FormWizard, TabContent } from 'vue3-form-wizard'
import { useOpenBisStore } from '@/composables/openbisAPI.js'
import 'vue3-form-wizard/dist/style.css'
const tab = ref('')
const test = true
const MINDESCLENGTH = 20 // Minimum length of the description field
const store = useOpenBisStore()
const form = reactive({
  projectContext: {
    space: '',
    name: '',
    contactPerson: null,
    manager: null,
    description: '',
  },
  sampleSources: {
    variables: [],
    species: '',
  },
})
const { sampleSources } = toRefs(form)

const variables = ref([
  { title: 'genotype' }, { title: 'species' },
])

const SPECIES = ['species1', 'species2']

const projectSpaces = ref([])
const people = ref([])
// List of default variables

onMounted(async () => {
  const SpaceSearchCriteria = store.loadedResources.SpaceSearchCriteria
  const SpaceFetchOptions = store.loadedResources.SpaceFetchOptions

  // now you can use SpaceSearchCriteria and SpaceFetchOptions
  const criteria = new SpaceSearchCriteria()
  const fo = new SpaceFetchOptions()

  const spaces = await store.searchSpaces(criteria, fo)
  projectSpaces.value = spaces.objects.map(space => space.code)
})

const submitForm = () => {
  formOutput.value = JSON.stringify(form, null, 2) // The stringify function arguments provide a pretty print format
}

// form wizzard functions
function checkProjectContext() {
  if (form.projectContext.space === '' || form.projectContext.name === ''
    || form.projectContext.description === '' || length(form.projectContext.description) < MINDESCLENGTH
  ) {
    alert('Please enter a project context')
    return test // TODO: Returning true will prevent the user from moving to the next tab
  }
  return true
}

function onComplete() {
  alert('Yay. Done!')
}

// TODO: dynamically copmpute the objects and v-model them   
</script>

<template>
  <v-container>
    <v-tabs
      v-model="form.tab"
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
    <v-window v-model="form.tab">
      <v-window-item :key="1" value="Create">
        <v-form>
          <FormWizard @on-complete="onComplete">
            <TabContent title="Project Context" :before-change="checkProjectContext">
              <v-autocomplete
                v-model="form.projectContext.space"
                :items="projectSpaces"
                label="Project-Space"
                :rules="[value => !!value || 'Item is required']"
              />

              <v-text-field
                v-model="form.projectContext.name"
                label="New Project Name"
                :rules="[value => !!value || 'Item is required']"
              />

              <v-autocomplete
                v-model="form.projectContext.contactPerson"
                :items="people"
                label="Contact Person"
              />

              <v-autocomplete
                v-model="form.projectContext.manager"
                :items="people"
                label="Project Manager"
              />

              <v-textarea
                v-model="form.projectContext.description"
                :counter="2000"
                label="Description"
                :rules="[value => !!value || 'Item is required', value => (value && value.length >= MINDESCLENGTH) || 'Item must be at least 20 characters']"
              />
            </TabContent>

            <TabContent title="Sample Sources">
              <v-autocomplete
                v-model="sampleSources.variables"
                label="Experimental variables"
                box
                chips
                :items="variables"
                multiple
                return-object
              />
              <div
                v-if="sampleSources.variables.some(variables => variables.title === 'species') " style="margin-left: 20px"
              >
                How many different species are there in this project?
                <v-text-field
                  v-model="sampleSources.variablespeciesNumber"
                  type="number"
                  label="Number of species"
                />
                <v-checkbox
                  v-if="sampleSources.variables.includes('species')"
                  v-model="sampleSources.isInfectiousStudy"
                  label="Infectious Study"
                />
              </div>

              <v-autocomplete
                v-model="sampleSources.species"
                label="species"
                :items="SPECIES"
                return-object
              />
              <div v-if="sampleSources.variables.length !== 0">
                <v-card>
                  <v-tabs v-model="tab" bg-color="primary">
                    <v-tab v-for="(item, index) in sampleSources.variables.map(v => v.title)" :key="index" :value="item">
                      {{ item }}
                    </v-tab>
                  </v-tabs>
                  <v-card-text>
                    <v-window v-model="tab">
                      <v-window-item v-for="(item, index) in sampleSources.variables.map(v => v.title)" :key="index" :value="item">
                        <!-- if species, create a species selector -->
                        <div v-if="item === 'species' && sampleSources.variablespeciesNumber">
                          <div v-for="(n) in Number(sampleSources.variablespeciesNumber)" :key="n">
                            Species {{ n }}
                            <v-text-field v-bind="sampleSources.species[`species${n}`] " />
                          </div>
                        </div>
                        <div v-else>
                          {{ item }} content
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
  <pre>{{ form }}</pre>
</template>
