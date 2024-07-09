<script setup lang="ts">
import openbis from '~/composables/openbis.esm'
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useProjectStore } from '~/composables/projectStore'

const router = useRouter()
const route = useRoute()

const spaceId = ref(route.params.space_id)
const projectId = ref(route.params.project_id)

// Initialize the project store and collection store
const collectionStore = useCollectionStore()
const projectStore = useProjectStore()

// Reactive references to store projects and collections
const collections = ref([] as openbis.Experiment[])
const project = ref<openbis.Project | null>(null)

const errorMessage = ref<string | null>(null)

// Function to fetch collections for a specific project
async function fetchCollections(projectPermId: openbis.ProjectPermId) {
  collections.value = await collectionStore.listCollectionsOfProject( projectPermId )
}

// Function to fetch project details
async function fetchProjectDetails(projectPermId: string): Promise<void> {
  try {
    if (projectId.value) {
      project.value = await projectStore.getProject(projectPermId)
    }
    console.log('project',project.value)
  } catch (error) {
    errorMessage.value = 'Failed to fetch project details'
  }
}

// Function to navigate to a collection detail page
function goToCollection (permId: string) {
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


// Function to delete the project
const deleteProject = async () => {
  try {
    await projectStore.deleteProject(projectId.value as string,"because");
    // Optionally, navigate back to a parent or home page after deletion
    router.push(`/data/spaces/${spaceId.value}/`);
  } catch (error) {
    errorMessage.value = 'Failed to delete project';
  }
}

onMounted(() => {
  const projectPermId = new openbis.ProjectPermId(projectId.value as string)
  // set project context code 
  useWizzardStore().projectContext.code = projectId.value as string
  fetchCollections(projectPermId)
  fetchProjectDetails(projectId.value as string)
})
</script>

<template>
  <v-container> 
    
   <div v-if="project">
      <h2>{{ project.getCode() }}</h2>
      <p>{{ project.getDescription() }}</p>
      <v-btn color="red" @click.stop="deleteProject">Delete Project</v-btn>
    </div>
    <h2>Collections/ Experinments</h2>
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
            <v-card-subtitle/>
            <v-card-text>{{ collection.getSamples().map(sample => sample.getCode()).join(', ') }}</v-card-text>
          </v-card>
        </v-col>
      </v-row>
      <v-row>
        <v-col/>
      </v-row>
    </template>
    <v-alert v-if="errorMessage" type="error">
      {{ errorMessage }}
    </v-alert>
     
    <ButtonCreateCollection
      :space-id="spaceId as string"
      :project-id="projectId as string"

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