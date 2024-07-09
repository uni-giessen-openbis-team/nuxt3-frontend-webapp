<script lang="ts" setup>
// use the store.experiment to display the experiment setup
const { collectionContext } = storeToRefs(useWizzardStore());


</script>

<template>
  <div>
    <h1>Experiment Setup</h1>
    <!-- input the name -->
    <v-text-field v-model="collectionContext.code"  label="Experiment Code" />
    <!-- input the description -->
    <v-text-field v-model="collectionContext.description" />
  </div>
</template>


