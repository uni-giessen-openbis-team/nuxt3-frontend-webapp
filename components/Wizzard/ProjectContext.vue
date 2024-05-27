<script setup lang="ts">


const MINDESCLENGTH = 20;

const wizzardStore = useWizzardStore();
const { projectContext } = storeToRefs(wizzardStore);
const saveProject = () => {
  // Logic to save the project
  wizzardStore.createProject(projectContext.value);
};
</script>


<template>
  <div>
    <APIComponentsAutocompleteSpaces
      v-model="projectContext.space"
    /> 
    <v-text-field
      v-model="projectContext.name"
      label="New Project Name"
      :rules="[value => !!value || 'Item is required']"
    />

    <APIComponentsAutocompletePersons
      v-model="projectContext.contactPerson"
      :space="projectContext.space"
      label="Contact Person"
    />

    <APIComponentsAutocompletePersons
      v-model="projectContext.manager"
      :space="projectContext.space"
      label="Project Manager"
    />

    <v-textarea
      v-model="projectContext.description"
      :counter="2000"
      label="Description"
      :rules="[value => !!value || 'Item is required', value => (value && value.length >= MINDESCLENGTH) || 'Item must be at least 20 characters']"
    />
  </div>

</template>
