<template>
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
        <v-btn color="blue darken-1" text @click="saveProject">Save</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script setup lang="ts">
import ProjectContext from '@/components/Wizzard/ProjectContext.vue'
import { ref } from 'vue'
import { useProjectStore } from '@/stores/projectStore'

const showModal = ref(false)
const projectStore = useProjectStore()

const saveProject = () => {
  projectStore.projectContext.space = space.value?.code ?? null;
  projectStore.createProject(projectStore.projectContext);
  showModal.value = false;
};

</script>
