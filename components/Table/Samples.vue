<template>
  <v-container>
    <v-simple-table>
      <thead>
        <tr>
          <th>Sample Code</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="sample in samples" :key="sample.permId.permId">
          <td>{{ sample.code }}</td>
          <td>{{ sample.properties.description ? sample.properties.description : 'No description available' }}</td>
        </tr>
      </tbody>
    </v-simple-table>
  </v-container>
</template>

<script setup lang="ts">
import { defineProps } from 'vue'
import openbis from '@/composables/openbis.esm'

const props = defineProps<{
  samples: openbis.Sample[]
}>()
</script>

<style scoped>
</style>
