<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import openbis from '@/composables/openbis.esm'

// Initialize the route
const route = useRoute()
const spaceId = route.params.space_id as string
const projectId = route.params.project_id as string
const collectionId = route.params.collection_id as string
const collection = ref<openbis.Experiment | null>(null)

// Initialize the sample store
const sampleStore = useSampleStore()
const collectionStore = useCollectionStore()

// Reactive references to store samples
const samples = ref<openbis.Sample[]>([])

// Function to fetch samples for a specific collection
const fetchSamples = async (collectionPermId: string) => {
  const collection = await collectionStore.getCollection(collectionPermId)
  if (collection) {
    samples.value = await collection.getSamples()
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
    <v-btn :to="`/data/spaces/${spaceId}/${projectId}/${collectionId}/wizzard`" >   
      Create Samples for this Collection
    </v-btn>
  </v-container>

  <v-container v-if="samples">
    <v-row>
      <v-col
        v-for="sample in samples"
        :key="sample.getPermId().toString()"
        cols="12"
        sm="6"
        md="4"
      >
        <v-card class="sample-card">
          <v-card-title>{{ sample.getCode() }}</v-card-title>
          <v-card-subtitle>{{ sample.getProperties().description }}</v-card-subtitle>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>
