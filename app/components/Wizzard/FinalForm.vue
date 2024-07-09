
<script setup lang="ts">
import { ref, watch } from 'vue';
import { useWizzardStore } from '~/app/composables/wizzardStore';

const wizzardStore = useWizzardStore();

// Use the projectContext from the store
const {projectContext} = storeToRefs(wizzardStore );

// Watch the local projectContext and update the store whenever it changes
watch(projectContext, (newVal) => {
  wizzardStore.projectContext = newVal;
}, { deep: true });

const finalize = async () => {
  try {
    await wizzardStore.finalizeProject(wizzardStore);
    alert('Project finalized successfully!');
  } catch (error) {
    console.error('Error finalizing project:', error);
    alert('An error occurred while finalizing the project.');
  }
};
</script>



<template>
  <div>
    <h2>Finalize Project</h2>
    <form @submit.prevent="finalize">
      <div>
        <label for="projectName">Project Name:</label>
        <input type="text" id="projectName" v-model="projectContext.name" />
      </div>
      <div>
        <label for="projectSpace">Project Space:</label>
        <input type="text" id="projectSpace" v-model="projectContext.space" />
      </div>
      <div>
        <label for="projectDescription">Project Description:</label>
        <textarea id="projectDescription" v-model="projectContext.description"></textarea>
      </div>
      <div>
        <label for="contactPerson">Contact Person:</label>
        <input type="text" id="contactPerson" v-model="projectContext.contactPerson" />
      </div>
      <div>
        <label for="manager">Manager:</label>
        <input type="text" id="manager" v-model="projectContext.manager" />
      </div>
      <button type="submit">Finalize Project</button>
    </form>
  </div>
</template>
