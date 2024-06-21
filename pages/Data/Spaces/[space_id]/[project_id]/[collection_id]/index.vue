<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import openbis from '@/composables/openbis.esm'
import Collections from '~/pages/Data/collections.vue';

// Initialize the route
const route = useRoute()
const spaceId = route.params.space_id as string
const projectId = route.params.project_id as string
const collectionId = route.params.collection_id as string
const collection = ref<openbis.Experiment | null>(null)

// Initialize the sample store
const collectionStore = useCollectionStore()

// Reactive references to store samples
const samples = ref<openbis.Sample[]>([])

// Function to fetch samples for a specific collection
const fetchSamples = async (collectionPermId: string) => {
  const collection = await useSampleStore().listSamplesOfCollection(collectionPermId)
  if (collection) {
    samples.value = await collection
  } else {
    console.error(`Collection with id ${collectionPermId} not found.`)
  }
}

onMounted(async () => {
  //get collection
  collection.value = await collectionStore.getCollection(collectionId)

  fetchSamples(collectionId)
  // set collection context code
  useWizzardStore().collectionContext.code = collectionId as string
  useWizzardStore().projectContext.code = projectId as string
  useWizzardStore().spaceContext.code = spaceId as string
})

// Function to delete a collection
const deleteCollection = async (permId: string) => {
    await collectionStore.deleteCollection(permId ,"because");
}
import Samples from '@/components/Table/Samples.vue'
import ExperimentSetup from '~/components/Wizzard/ExperimentSetup.vue';
</script>

<style scoped>
.sample-card {
  cursor: pointer;
  transition: transform 0.2s;
}
.sample-card:hover {
  transform: scale(1.05);
}



</style>


<template>
  <v-container>
    <h1>
      Experiment:
      {{  collection?.getCode() }}
 
    </h1>

    <v-btn :to="`/data/spaces/${spaceId}/${projectId}/${collectionId}/wizzard`" >   
      Create Samples for this Collection
    </v-btn>
    <Samples :samples="samples" />
  </v-container>

</template>
