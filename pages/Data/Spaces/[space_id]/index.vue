
<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import openbis from '@/composables/openbis.esm'

const space = ref<openbis.Space | null>(null)
const projects = ref<openbis.Project[]>([])
const error = ref<Error | null>(null)
const router = useRouter()
const route = useRoute()
const spaceStore = useSpaceStore()
const projectStore = useProjectStore()



const deleteSpace = async () => {
  try {
    const spaceId = route.params.space_id
    const ISpaceId = new openbis.SpacePermId(Array.isArray(spaceId) ? spaceId[0] : spaceId)
    await spaceStore.deleteSpace(ISpaceId.getPermId(), "Because I want to")
    router.push('/data/spaces')
  } catch (err) {
    error.value = err as Error
  }
}

const fetchSpaceDetails = async () => {
  try {
    const spaceId = route.params.space_id
    projects.value = await projectStore.getProjectsOfSpace(String(spaceId))
  } catch (err) {
    error.value = err as Error
  }
}

const goToProject = (projectPermId: openbis.ProjectPermId) => {
  router.push(`/data/spaces/${route.params.space_id}/${projectPermId}`)
}
 

onMounted(fetchSpaceDetails)
</script>

<style scoped>
.project-card {
  cursor: pointer;
  transition: transform 0.2s;
}

.project-card:hover {
  transform: scale(1.05);
}

</style>

<template>
  
  <v-container>
    <h1>Space {{route.params.space_id}}</h1>
 
    <v-row>
    </v-row>
    <v-row>
      <v-col cols="12">
        <h2>{{ space?.getCode() ?? '' }}</h2>
        <v-btn @click="deleteSpace" color="red">Delete Space</v-btn>
      </v-col>
    </v-row>
    <br>
    <template v-if="projects.length > 0">
      <v-row>
        <v-col cols="12">
          <h2>Projects</h2>
        </v-col>
      </v-row>
      <v-row>
        <v-col v-for="project in projects" :key="project?.getPermId().toString()" cols="12" sm="6" md="4">
          <v-card @click="goToProject(project?.getPermId())" class="project-card">
            <v-card-title>{{ project?.getCode() ?? '' }}</v-card-title>
            <v-card-subtitle>{{ project?.getDescription() ?? '' }}</v-card-subtitle>
            <v-card-text>
              {{project?.getPermId()}}
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </template>
    <template v-else>
      <v-alert type="info">
        No projects available. Please create a new project.
      </v-alert>
    </template>
    <v-alert v-if="error" type="error">
      {{ error?.message ?? '' }}
    </v-alert>
    <br>
      <ButtonCreateProject :spaceId="route.params.space_id as string"></ButtonCreateProject>
  </v-container>


 
</template>
