<script setup lang="ts">
import { ref, onMounted } from 'vue'
import type openbis from '~/composables/openbis.esm'

const experimentCode = "20241028121038965-26"
const collection = ref<openbis.Experiment | null>(null)

// Function to fetch samples for a specific collection
const handleFetchSamples = async (experimentPermId: string): Promise<openbis.Sample[]> => {
  const samples = await listSamplesOfCollection(experimentPermId)
  return samples
}

const samples = ref<openbis.Sample[]>([])
const wizardStore = useWizardStore()

onMounted(async () => {
  collection.value = await getCollection(experimentCode)
  samples.value = await handleFetchSamples(experimentCode)
})

// Function to delete a collection
const handleDeleteCollection = async (permId: string) => {
  await deleteCollection(permId, "because");
}

const selectedSamples = ref<openbis.Sample[]>([])

const headers = [
  { title: 'Select', value: 'select' },
  { title: 'Sample Code', value: 'code' },
  { title: 'Children', value: 'children' },
  { title: 'Registration Date', value: 'registrationDate' },
  { title: 'Modification Date', value: 'modificationDate' },
  { title: 'Properties', value: 'properties' },
  { title: 'Actions', value: 'actions' }
]


</script>


<template>
  <v-container>
    <h1>
      Entities
    </h1>


    <v-data-table
      v-model="selectedSamples"
      class="mt-10 mb-10"
      :headers="headers"
      :items="samples"
      items-per-page="30"
      show-select
    >
 
      <!-- Sample Code Column -->
      <template #item.code="{ item }">
        <v-btn variant="text" :to="`sample/${item.getPermId()}`">
          {{ item.getCode() }}
        </v-btn>
      </template>

      <!-- Children Column -->
      <template #item.children="{ item }">
        <ul>
          <li v-for="child in item.getChildren()" :key="child.getPermId()">
            <v-btn variant="text" :to="`/Sample/${child.getPermId()}`">
              {{ child.getCode() }}
            </v-btn>
          </li>
        </ul>
      </template> 

      <!-- Actions Column -->
      <template #item.actions="{ item }">
        <v-btn color="red" icon @click="handleDeleteCollection(item.getIdentifier().toString())">
          <v-icon>mdi-close</v-icon>
        </v-btn>
      </template>
    </v-data-table>
 
    {{selectedSamples}}

  </v-container>
      <!-- <v-btn :to="`/Experiment/${experimentCode}/wizard`">
      Wizard
    </v-btn> -->
</template>

