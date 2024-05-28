
<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import openbis from '@/composables/openbis.esm'
import AddProjectModal from '@/components/AddProjectModal.vue'

const space = ref<openbis.Space | null>(null)
const showModal = ref(false)
const projects = ref<openbis.Project[]>([])
const error = ref<Error | null>(null)
const router = useRouter()
const route = useRoute()
const spaceStore = useSpaceStore()
const projectStore = useProjectStore()



const deleteSpace = async () => {
  try {
    const spaceId = route.params.space_id
    const ISpaceId = new openbis.SpacePermId(spaceId)
    await spaceStore.deleteSpace(ISpaceId)
    router.push('/data/spaces')
  } catch (err) {
    error.value = err as Error
  }
}

const fetchSpaceDetails = async () => {
  try {
    const spaceId = route.params.space_id
    const ISpaceId = new openbis.SpacePermId(spaceId)     
    space.value = await spaceStore.getSpace(ISpaceId) ?? null
    projects.value = await projectStore.getProjectsOfSpace(ISpaceId)
  } catch (err) {
    error.value = err as Error
  }
}

const goToProject = (projectId: string) => {
  router.push(`/data/spaces/${route.params.space_id}/${projectId}`)
}

const saveProject = () => {
  projectStore.projectContext.space = space.value?.code ?? null;
  projectStore.createProject(projectStore.projectContext);
  showModal.value = false;
};

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
    <v-row>
      {{route.params.space_id}}
    </v-row>
    <v-row>
      <v-col cols="12">
        <h1>{{ space?.getCode() ?? '' }}</h1>
        <v-btn @click="deleteSpace" color="red">Delete Space</v-btn>
        
        <v-btn @click="showModal = true" color="primary">Add New Project</v-btn>
      </v-col>
     
        
    
    </v-row>
    
    <v-row>
      <v-col cols="12">
        <h2>Projects</h2>
      </v-col>
    </v-row>
    <v-row>
      <v-col v-for="project in projects" :key="project?.getPermId()" cols="12" sm="6" md="4">
        <v-card @click="goToProject(project?.getPermId())" class="project-card">
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
  <AddProjectModal />
</template>
