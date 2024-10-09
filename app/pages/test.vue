<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import { useProjectStore } from '~/app/composables/projectStore';
import type openbis from '~/composables/openbis.esm';

const project = ref<openbis.Project | null>(null);
const error = ref<Error | null>(null);
const route = useRoute();
const projectStore = useProjectStore();

const fetchProjectDetails = async () => {
  try {
    const projectId = route.query.projectId as string;
    project.value = await projectStore.getProjectCompletely(projectId);
  } catch (err) {
    error.value = err as Error;
  }
};

onMounted(fetchProjectDetails);
</script>

<template>
  <v-container>
    <h1>Project Details</h1>
    <template v-if="project">
      <v-row>
        <v-col cols="12">
          <h2>{{ project.getCode() }}</h2>
          <p>{{ project.getDescription() }}</p>
        </v-col>
      </v-row>
    </template>
    <v-alert v-else type="info">
      Loading project details...
    </v-alert>
    <v-alert v-if="error" type="error">
      {{ error.message }}
    </v-alert>
  </v-container>
</template>

<style scoped>
h1 {
  margin-bottom: 20px;
}
</style>
