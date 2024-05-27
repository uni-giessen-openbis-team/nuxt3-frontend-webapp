<template>
  <v-container>
    <v-row>
      <v-col cols="12">
        <v-btn @click="showModal = true" color="primary">Add New Project</v-btn>
      </v-col>
    </v-row>
    <v-row v-if="space">
      <v-col cols="12">
        <v-card>
          <v-card-title>{{ space?.code ?? '' }}</v-card-title>
          <v-card-subtitle>{{ space?.description ?? '' }}</v-card-subtitle>
        </v-card>
      </v-col>
    </v-row>
    <v-row>
      <v-col cols="12">
        <h2>Projects</h2>
      </v-col>
    </v-row>
    <v-row>
      <v-col v-for="project in projects" :key="project?.permId?.permId ?? ''" cols="12" sm="6" md="4">
        <v-card @click="goToProject(project?.permId?.permId ?? '')" class="project-card">
          <v-card-title>{{ project?.getCode() ?? '' }}</v-card-title>
          <v-card-subtitle>{{ project?.description ?? '' }}</v-card-subtitle>
          <v-card-text>

            {{project?.permId?.permId}}
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
    <v-alert v-if="error" type="error">
      {{ error?.message ?? '' }}
    </v-alert>
  </v-container>
  <v-dialog v-model="showModal" max-width="600px">
    <v-card>
      <v-card-title>
        <span class="headline">Add New Project</span>
      </v-card-title>
      <v-card-text>
        <ProjectContext />
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="blue darken-1" text @click="showModal = false">Cancel</v-btn>
        <v-btn color="blue darken-1" text @click="addProject">Save</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import openbis from '@/composables/openbis.esm'
import ProjectContext from '@/components/Wizzard/ProjectContext.vue'

import ProjectContext from '@/components/Wizzard/ProjectContext.vue'

const space = ref<openbis.Space | null>(null)
const showModal = ref(false)
const showModal = ref(false)
const projects = ref<openbis.Project[]>([])
const error = ref<Error | null>(null)
const router = useRouter()
const route = useRoute()
const spaceStore = useSpaceStore()
const projectStore = useProjectStore()



const fetchSpaceDetails = async () => {
  try {
    const spaceId = route.params.space_id
    space.value = await spaceStore.getSpace(spaceId)
    console.log("🚀 ~ fetchSpaceDetails ~ space.value :", space.value )
    projects.value = await projectStore.getProjectsOfSpace(spaceId)
  } catch (err) {
    error.value = err as Error
  }
}

const goToProject = (projectId: string) => {
  router.push(`/data/spaces/${route.params.space_id}/${projectId}`)
}

const addProject = () => {
  // Logic to add the project
  showModal.value = false
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
