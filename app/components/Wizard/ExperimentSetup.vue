<script lang="ts" setup>
// use the store.experiment to display the experiment setup


</script>

<template>
  <div>
    <h1>Experiment Setup</h1>
    <!-- input the name -->
    <v-text-field v-model="useRoute().query.collectionCode"  label="Experiment Code" />
    <!-- input the description -->
  </div>
</template>


