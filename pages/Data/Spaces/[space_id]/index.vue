<template>
  <v-container>
    <v-row v-if="space">
      <v-col cols="12">
        <v-card>
          <v-card-title>{{ space.code }}</v-card-title>
          <v-card-subtitle>{{ space.description }}</v-card-subtitle>
        </v-card>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12">
        <h2>Projects</h2>
      </v-col>
    </v-row>
    <v-row>
      <v-col
        v-for="project in projects"
        :key="project.permId.permId"
        cols="12"
        sm="6"
        md="4"
      >
        <v-card @click="goToProject(project.permId.permId)" class="project-card">
          <v-card-title>{{ project.code }}</v-card-title>
          <v-card-subtitle>{{ project.description }}</v-card-subtitle>
        </v-card>
      </v-col>
    </v-row>
    <v-alert v-if="error" type="error">
      {{ error.message }}
    </v-alert>
  </v-container>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useLogger } from '@/composables/logger'

const space = ref(null)
const projects = ref([])
const error = ref<Error | null>(null)
const router = useRouter()
const route = useRoute()
const spaceStore = useSpaceStore()
const projectStore = useProjectStore()

const logger = useLogger()

const fetchSpaceDetails = async () => {
  logger.info('Fetching space details started')
  try {
    const spaceId = route.params.space_id
    space.value = await spaceStore.getSpace(spaceId)
    projects.value = await projectStore.getProjectsOfSpace(spaceId)
  } catch (err) {
    error.value = err as Error
  }
}

const goToProject = (projectId: string) => {
  router.push(`/data/spaces/${route.params.space_id}/projects/${projectId}`)
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
