
<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const projectStore = useProjectStore()
const projects = ref(projectStore.projects)
const router = useRouter()

const fetchProjects = async () => {
  await projectStore.getProjects()
}

const goToProject = (permId: string) => {
  router.push(`/projects/${permId}`)
}

onMounted(fetchProjects)
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
      <v-col
        v-for="project in projects"
        :key="project.permId"
        cols="12"
        sm="6"
        md="4"
      >
        <v-card @click="goToProject(project.permId)" class="project-card">
          <v-card-title>{{ project.code }}</v-card-title>
          <v-card-subtitle>{{ project.description }}</v-card-subtitle>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>
