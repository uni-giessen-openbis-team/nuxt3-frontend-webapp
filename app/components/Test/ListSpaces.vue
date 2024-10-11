<template>
    <div>
      <h1>Spaces</h1>
      <ul>
        <li v-for="space in spaces" :key="space.permId">
          {{ space.getCode() }} - {{ space.getDescription() }}
        </li>
      </ul>
    </div>
  </template>
  
  <script setup lang="ts">
  import { getAllSpaces } from '@/composables/api-connector/spaces';
  import type openbis from '~/composables/openbis.esm';


   
const spaces = ref<openbis.Space[]>([]);
  
onMounted(async () => {
try {
    spaces.value = await getAllSpaces();
} catch (error) {
    console.error('Failed to fetch spaces:', error);
}
});
 </script>
  