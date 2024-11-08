<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import openbis from '~/composables/openbis.esm'

const space = ref<openbis.Space | null>(null)
const projects = ref<openbis.Project[]>([])
const error = ref<Error | null>(null)
const router = useRouter()
const route = useRoute()

const deleteCurrentSpace = async () => {
  try {
    const spaceId = route.params.space_id
    const ISpaceId = new openbis.SpacePermId(Array.isArray(spaceId) ? spaceId[0] : spaceId)
    await deleteSpace(ISpaceId.getPermId(), "Because I want to")
    router.push('/data/spaces')
  } catch (err) {
    error.value = err as Error
  }
}

const fetchSpaceDetails = async () => {
  try {
    const spaceId = route.params.space_id
    projects.value = await getProjectsOfSpace(String(spaceId))
  } catch (err) {
    error.value = err as Error
  }
}

const goToProject = (projectPermId: openbis.ProjectPermId) => {
  router.push(`/Project/${projectPermId.toString()}`)
}
 

onMounted(fetchSpaceDetails)
</script>

<template>
  
  <v-container>
    <h1>Space: {{route.params.space_id}}</h1>
    <pre>
        {{ space?.getCode() }}
    </pre>
    <v-row/>

        
        <v-btn color="red" @click="deleteCurrentSpace">Delete Space</v-btn>

    <br>
    <template v-if="projects.length > 0">
      <v-row>
        <v-col cols="12">
          <h2>Projects</h2>
        </v-col>
      </v-row>
      <v-row>
        <v-col v-for="project in projects" :key="project?.getPermId().toString()" cols="12" sm="6" md="4">
          <v-card class="project-card" @click="goToProject(project?.getPermId())">
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
      <ButtonCreateProject :space-id="route.params.space_id as string"/>
  </v-container>
</template>

<style scoped>
.project-card {
  cursor: pointer;
  transition: transform 0.2s;
}

.project-card:hover {
  transform: scale(1.05);
}

</style>