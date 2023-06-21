<script setup>
import { ref } from 'vue'
const tab = ref('Create')
const files = ref([])
const projectSpace = ref('')
const projectSpaces = ref([]) // Populate with your data

const imagingSupport = ref(false)

const subProject = ref('')
const subProjects = ref([]) // Populate with your data

const newSubProjectCode = ref('')
const projectName = ref('')

const principalInvestigator = ref('')
const contactPerson = ref('')
const projectManager = ref('')
const people = ref([]) // Populate with your data

const description = ref('')

const projectContext = ref('')

const generateCode = () => {
  newSubProjectCode.value = Math.random().toString(36).substring(2, 7).toUpperCase()
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
          <v-autocomplete
            v-model="projectSpace"
            :items="projectSpaces"
            label="Project/Space"
          />

          <v-checkbox
            v-model="imagingSupport"
            label="Imaging Support"
          />

          <v-autocomplete
            v-model="subProject"
            :items="subProjects"
            label="Sub-Project"
          />

          <v-text-field
            v-model="newSubProjectCode"
            label="New Sub-Project Code"
            :rules="[value => value.length === 5 || 'Code must be 5 characters']"
            suffix="Generate"
            @click:suffix="generateCode"
          />

          <v-text-field
            v-model="projectName"
            label="Project Name"
          />

          <v-autocomplete
            v-model="principalInvestigator"
            :items="people"
            label="Principal Investigator"
          />

          <v-autocomplete
            v-model="contactPerson"
            :items="people"
            label="Contact Person"
          />

          <v-autocomplete
            v-model="projectManager"
            :items="people"
            label="Project Manager"
          />

          <v-textarea
            v-model="description"
            :counter="2000"
            label="Description"
          />

          <v-radio-group v-model="projectContext">
            <v-radio label="Add new experiment" value="Add new experiment" />
            <v-radio label="Create empty sub-project" value="Create empty sub-project" />
          </v-radio-group>
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
</template>
