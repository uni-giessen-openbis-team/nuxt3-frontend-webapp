<script setup lang="ts">
import openbis from '@/composables/openbis.esm'
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useProjectStore } from '@/composables/projectStore'

const router = useRouter()
const route = useRoute()

const spaceId = ref(route.params.space_id)
const projectId = ref(route.params.project_id)
const collectionId = ref(route.params.collection_id)

// Initialize the project store and collection store
const collectionStore = useCollectionStore()
const projectStore = useProjectStore()

// Reactive references to store projects and collections
const collections = ref([] as openbis.Experiment[])
const project = ref<openbis.Project | null>(null)

const errorMessage = ref<string | null>(null)

// Function to fetch collections for a specific project
const fetchCollections = async (projectPermId: openbis.ProjectPermId) => {
  collections.value = await collectionStore.listCollectionsOfProject( projectPermId )
}

// Function to fetch project details
const fetchProjectDetails = async (projectPermId: string) => {
  try {
    project.value = await projectStore.getProject(projectPermId)
  } catch (error) {
    errorMessage.value = 'Failed to fetch project details'
  }
}

// Function to navigate to a collection detail page
const goToCollection = (permId: string) => {
  router.push(`/data/spaces/${spaceId.value}/${projectId.value}/${permId}/`)
}

// Function to create a new collection
const newCollection = ref({
  code: '',
  typeId: '',
  properties: {
    description: ''
  }
})

onMounted(() => {
  const projectPermId = new openbis.ProjectPermId(projectId.value as string)
  fetchCollections(projectPermId)
  fetchProjectDetails(projectId.value as string)
})
</script>

<template>
  <v-container> 
    <h1>Project {{ projectId }}</h1>
    <div v-if="project">
      <h2>{{ project.getCode() }}</h2>
      <p>{{ project.getDescription() }}</p>
    </div>
    <h2>Collections</h2>
    <template v-if="collections.length > 0">
      <v-row>
        <v-col
          v-for="collection in collections" 
          :key="collection.getPermId().toString()"
          cols="12"
          sm="6"
          md="4"
        >
          <v-card class="collection-card" @click="goToCollection(collection.getPermId().toString())">
            <v-card-title>{{ collection.getCode() }}</v-card-title>
            <v-card-subtitle></v-card-subtitle>
            <v-card-text>{{ collection.getSamples().map(sample => sample.getCode()).join(', ') }}</v-card-text>
          </v-card>
        </v-col>
      </v-row>
      <v-row>
        <v-col>
         
        </v-col>
      </v-row>
    </template>
    <v-alert v-if="errorMessage" type="error">
      {{ errorMessage }}
    </v-alert>
     
    <ButtonCreateCollection 
            :spaceId="spaceId"
            :projectId="projectId"
            :collectionId="collectionId"
          />
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