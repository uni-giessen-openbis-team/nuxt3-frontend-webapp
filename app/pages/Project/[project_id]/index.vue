<script setup lang="ts">
import openbis from '~/composables/openbis.esm'
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'

const router = useRouter()
const route = useRoute()

const spaceId = ref(route.params.space_id)
const projectId = ref(route.params.project_id)


// Reactive references to store projects and collections
const collections = ref([] as openbis.Experiment[])
const project = ref<openbis.Project | null>(null)

const errorMessage = ref<string | null>(null)

// Function to fetch collections for a specific project
async function handleFetchCollections(projectPermId: openbis.ProjectPermId) {
  collections.value = await listCollectionsOfProject( projectPermId )
}

// Function to fetch project details
async function handleFetchProjectDetails(projectPermId: string): Promise<void> {
  try {
    if (projectId.value) {
      project.value = await getProject(projectPermId)
    }
    console.log('project',project.value)
  } catch (error) {
    errorMessage.value = 'Failed to fetch project details, ' + error
  }
}

// Function to navigate to a collection detail page
function goToCollection (permId: string) {
  router.push(`/Experiment/${permId}/`)
}


// Function to delete the project
const handleDeleteProject = async () => {
  try {
    await deleteProject(projectId.value as string,"because");
    // Optionally, navigate back to a parent or home page after deletion
    router.push(`/data/spaces/${spaceId.value}/`);
  } catch (error) {
    errorMessage.value = 'Failed to delete project, ' + error;
  }
}

onMounted(() => {
  const projectPermId = new openbis.ProjectPermId(projectId.value as string)
  // set project context code 
  handleFetchCollections(projectPermId)
  handleFetchProjectDetails(projectId.value as string)
})
</script>

<template>
  <v-container> 
    
   <div v-if="project">
      <h1>{{ project.getCode() }}</h1>
      <br>
      <p>{{ project.getDescription() }}</p>
      <v-btn color="red" @click.stop="handleDeleteProject">Delete Project</v-btn>
      <br>
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