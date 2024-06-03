<template>
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

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import openbis from '@/composables/openbis.esm'

// Initialize the route
const route = useRoute()
const collectionId = route.params.collection_id as string

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

onMounted(() => {
  fetchSamples(collectionId)
})
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
