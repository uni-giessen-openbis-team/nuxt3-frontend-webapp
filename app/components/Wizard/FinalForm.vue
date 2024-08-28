<script setup lang="ts">
import { useWizardStore } from '~/composables/wizardStore';

const wizardStore = useWizardStore();

// Use the projectContext from the store
const {projectContext} = storeToRefs(wizardStore );

// Watch the local projectContext and update the store whenever it changes
watch(projectContext, (newVal) => {
  wizardStore.projectContext = newVal;
}, { deep: true });

const finalize = async () => {
  try {
    await wizardStore.finalizeProject(wizardStore);
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
        <input id="projectName" v-model="projectContext.name" type="text" >
      </div>
      <div>
        <label for="projectSpace">Project Space:</label>
        <input id="projectSpace" v-model="projectContext.space" type="text" >
      </div>
      <div>
        <label for="projectDescription">Project Description:</label>
        <textarea id="projectDescription" v-model="projectContext.description"/>
      </div>
      <div>
        <label for="contactPerson">Contact Person:</label>
        <input id="contactPerson" v-model="projectContext.contactPerson" type="text" >
      </div>
      <div>
        <label for="manager">Manager:</label>
        <input id="manager" v-model="projectContext.manager" type="text" >
      </div>
      <button type="submit">Finalize Project</button>
    </form>
  </div>
</template>
