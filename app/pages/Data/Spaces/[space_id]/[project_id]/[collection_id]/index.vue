<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import openbis from '~/composables/openbis.esm'

// Initialize the route
const route = useRoute()
const spaceId = route.params.space_id as string
const projectId = route.params.project_id as string
const collectionId = route.params.collection_id as string
const collection = ref<openbis.Experiment | null>(null)

// Initialize the sample store

// Reactive references to store samples
const samples = ref<openbis.Sample[]>([])

// Function to fetch samples for a specific collection
const handleFetchSamples = async (collectionPermId: string) => {
  const collection = await listSamplesOfCollection(collectionPermId)
  if (collection) {
    samples.value = await collection
  } else {
    console.error(`Collection with id ${collectionPermId} not found.`)
  }
}

// Function to navigate to sample details
const navigateToSample = (sampleId: string) => {
  const router = useRouter()
  router.push(`/data/spaces/${spaceId}/${projectId}/${collectionId}/${sampleId}`)
}

// Function to delete a sample
const deleteSample = async (sampleId: string) => {
  try {
    const sampleIdentifier = new openbis.SampleIdentifier(sampleId)
    const deletionOptions = new openbis.SampleDeletionOptions()
    deletionOptions.setReason("User requested deletion")
    const deletionId = await useOpenBisStore().v3?.deleteSamples([sampleIdentifier], deletionOptions)
    await useOpenBisStore().v3?.confirmDeletions([deletionId])
    handleFetchSamples(collectionId) // Refresh the samples list after deletion
  } catch (error) {
    console.error(`Failed to delete sample with id ${sampleId}:`, error)
  }
}

onMounted(async () => {
  //get collection
  collection.value = await getCollection(collectionId)

  handleFetchSamples(collectionId)
  // set collection context code
  useWizardStore().collectionContext.code = collectionId as string
  useWizardStore().projectContext.code = projectId as string
  useWizardStore().spaceContext.code = spaceId as string
})

// Function to delete a collection
const handleDeleteCollection = async (permId: string) => {
    await deleteCollection(permId ,"because");
}

const props = defineProps<{
  samples: openbis.Sample[]
}>()

const headers = [
  { title: 'Sample Code', value: 'code' },
  { title: 'Registration Date', value: 'registrationDate' },
  { title: 'Modification Date', value: 'modificationDate' },
  { title: 'Properties', value: 'properties' },
  { title: 'Actions', value: 'actions' } // New column for actions
]

const itemKey = 'id'

</script>

<template>
  <v-container>
    <h1>
      Experiment:
      {{  collection?.getCode() }}
 
    </h1>
    <v-btn :to="`/data/spaces/${spaceId}/${projectId}/${collectionId}/wizard`" >   
      <v-icon left>mdi-plus</v-icon> <!-- Added icon for data creation -->
      Create Samples
    </v-btn>

    <v-data-table
    class="mt-10 mb-10"
    :headers="headers"
    :items="samples"
    :item-key="itemKey"
    items-per-page="30"
  >
    <template #item.code="{ item }">
      <v-btn variant="text" :to="`/data/spaces/${spaceId}/${projectId}/${collectionId}/${item.getPermId()}`">
        {{ item.getCode() }}
      </v-btn>
    </template>
    <template #item.actions="{ item }">
      <v-btn color="red" icon @click="handleDeleteCollection(item.getIdentifier().toString())">
        <v-icon>mdi-close</v-icon>
      </v-btn>
    </template>
  </v-data-table>
  </v-container>

</template>



