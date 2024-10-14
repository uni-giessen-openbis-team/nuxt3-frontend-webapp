<script setup lang="ts">
import { ref } from 'vue';
import 'vue3-form-wizard/dist/style.css';
import type openbis from '~/composables/openbis.esm';
import type { Property } from '@/types/wizard';

const tab = ref('');

const route = useRoute()

const projectContext = {
  space_id: route.query.space_id as string,
  project_id: route.query.project_id as string,
  collection_id: route.query.collection_id as string,
}

// Select Variables from the List 

const searchTerm = ref('')
const vocabularyTerms = await listVocabularyTermsByVocabularyCode(searchTerm) || []


const entetyProperties = ref<Property[]>([
  {
    title: 'Property 1',
    description: 'Description 1',
    continuous: false,
    unit: null,
    conditions: []
  },
  // wih vocabulary
  {
    title: 'Property 2',
    description: 'Description 2',
    continuous: false,
    unit: null,
    conditions: []
  },
])
const biologicalProperties = ref<Property[]>([
  {
    title: 'Property 2',
    description: 'Description 2',
    continuous: false,
    unit: null,
    conditions: []
  },
])
const technicalProperties = ref<Property[]>([
  {
    title: 'Property 3',
    description: 'Description 3',
    continuous: false,
    unit: null,
    conditions: []
  },
])



</script>



<template>
  <v-container>
    <h2>
      Create new samples for collection {{ projectContext.collection_id }}
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


    <v-window v-model="tab">
      <v-window-item :key="1" value="Create">
        <WizardStepper />
      </v-window-item>
      <v-window-item :key="2" value="Upload">
        <v-form>
          <v-file-input label="File input" multiple chips clearable hint="Select one or more files" persistent-hint />
        </v-form>
      </v-window-item>
    </v-window>
  </v-container>
</template>