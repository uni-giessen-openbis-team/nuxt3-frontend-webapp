<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import type openbis from '~/composables/openbis.esm'

// Initialize the route
const route = useRoute()

const experimentId = route.params.experiment_id as string
const collection = ref<openbis.Experiment | null>(null)

// Function to fetch samples for a specific collection
const handleFetchSamples = async (experimentPermId: string) => {
  const collection = await listSamplesOfCollection(experimentPermId)
  return collection
}

const samples = ref<openbis.Sample[]>([])
const wizardStore = useWizardStore()

onMounted(async () => {
  collection.value = await getCollection(experimentId)
  samples.value = await handleFetchSamples(experimentId)
})

// Function to delete a collection
const handleDeleteCollection = async (permId: string) => {
  await deleteCollection(permId, "because");
}

const headers = [
  { title: 'Select', value: 'select' }, // New column for checkboxes
  { title: 'Sample Code', value: 'code' },
  { title: 'Registration Date', value: 'registrationDate' },
  { title: 'Modification Date', value: 'modificationDate' },
  { title: 'Properties', value: 'properties' },
  { title: 'Actions', value: 'actions' }
]

const itemKey = 'id'
</script>


<template>
  <v-container>
    <h1>
      Experiment:
      {{ collection?.getCode() }}
    </h1>
    <v-btn :to="`/Experiment/${experimentId}/wizard`">
      Wizard
    </v-btn>

    <v-data-table
      class="mt-10 mb-10"
      :headers="headers"
      :items="samples"
      :item-key="itemKey"
      items-per-page="30"
    >
      <!-- Checkbox Column -->
      <template #item.select="{ item }">
        <v-checkbox
          v-model="wizardStore.selectedSamples"
          :value="item"
          @change="wizardStore.toggleSample(item)"
        />
      </template>

      <!-- Sample Code Column -->
      <template #item.code="{ item }">
        <v-btn variant="text" :to="`sample/${item.getPermId()}`">
          {{ item.getCode() }}
        </v-btn>
      </template>

      <!-- Actions Column -->
      <template #item.actions="{ item }">
        <v-btn color="red" icon @click="handleDeleteCollection(item.getIdentifier().toString())">
          <v-icon>mdi-close</v-icon>
        </v-btn>
      </template>
    </v-data-table>
  </v-container>
</template>

