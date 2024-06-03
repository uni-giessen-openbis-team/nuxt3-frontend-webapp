<script setup lang="ts">
import openbis from '@/composables/openbis.esm'
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'


const router = useRouter()
const route = useRoute()

const spaceId = ref(route.params.space_id)
const projectId = ref(route.params.project_id)
const collectionId = ref(route.params.collection_id)
 
// Initialize the project store and collection store
const projectStore = useProjectStore()
const collectionStore = useCollectionStore()

// Reactive references to store projects and collections
const projects = ref([] as openbis.Project[])
const collections = ref([] as openbis.Experiment[])

// New collection data
const newCollection = ref({ 
  code: '',
  typeId: '',
  properties: {
    description: ''
  }
})

const errorMessage = ref<string | null>(null)

// Function to fetch collections for a specific project
const fetchCollections = async (projectPermId: string) => {
  collections.value = await collectionStore.listCollectionsOfProject({ permId: projectPermId })
  projectId.value = projectPermId
}

// Function to navigate to a collection detail page
const goToCollection = (permId: string) => {
  router.push(`/data/spaces/${spaceId.value}/${projectId.value}/${permId}/`)
}

// Function to create a new collection
const createCollection = async () => {
  try {
    const collectionCreation = collectionStore.prepareCollectionCreation(
      newCollection.value.code,
      newCollection.value.typeId,
      projectId.value,
      newCollection.value.properties
    )
    await collectionStore.createCollection(collectionCreation)
    await fetchCollections(projectId.value)
    resetNewCollection()
    errorMessage.value = null
  } catch (error) {
    errorMessage.value = 'Failed to create collection. Please try again.'
  }
}

// Reset new collection data
const resetNewCollection = () => {
  newCollection.value = {
    code: '',
    typeId: '',
    properties: {
      description: ''
    }
  }
}

onMounted(() => {
  fetchCollections(projectId.value)
})
</script>

<template>
  <v-container>
    <template v-if="collections.length > 0">
      <v-row>
        <v-col
          v-for="collection in collections"
          :key="collection.permId"
          cols="12"
          sm="6"
          md="4"
        >
          <v-card class="collection-card" @click="goToCollection(collection.permId)">
            <v-card-title>{{ collection.getCode() }}</v-card-title>
            <v-card-subtitle></v-card-subtitle>
            <v-card-text>{{ collection.getSamples().map(sample => sample.getCode()).join(', ') }}</v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </template>
    <template v-else>
      <v-alert type="info">
        No collections available for this project. Please create a new collection.
        <v-form @submit.prevent="createCollection">
          <v-text-field v-model="newCollection.code" label="Collection Code" required></v-text-field>
          <v-text-field v-model="newCollection.typeId" label="Type ID" required></v-text-field>
          <v-text-field v-model="newCollection.properties.description" label="Description"></v-text-field>
          <v-btn type="submit" color="primary">Create Collection</v-btn>
        </v-form>
      </v-alert>
    </template>

    <v-alert v-if="errorMessage" type="error">
      {{ errorMessage }}
    </v-alert>
  </v-container>
</template>


<style scoped>
.project-card,
.collection-card {
  cursor: pointer;
  transition: transform 0.2s;
}
.project-card:hover,
.collection-card:hover {
  transform: scale(1.05);
}
</style>