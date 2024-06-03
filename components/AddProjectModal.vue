<template>
  <v-dialog v-model="showModal" max-width="600px">
    <v-card>
      <v-card-title>
        <span class="headline">Add New Project</span>
      </v-card-title>
      <v-card-text>
        <WizzardProjectContext />
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn color="blue darken-1"  @click="showModal = false">Cancel</v-btn>
        <v-btn color="blue darken-1"  @click="saveProject">Save</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script setup lang="ts">

const showModal = ref(false)
const projectStore = useProjectStore()


const saveProject = () => {
  projectStore.projectContext.space = space.value?.code ?? null;
  projectStore.createProject(projectStore.projectContext);
  showModal.value = false;
};

</script>
