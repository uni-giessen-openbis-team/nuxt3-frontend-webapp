<!-- https://vuetifyjs.com/en/components/data-tables/basics/#headers -->
<template>
  <v-data-table
    class="mt-10 mb-10"
    :headers="headers"
    :items="samples"
    :item-key="itemKey"
    items-per-page="30"
  >

  </v-data-table>
  <pre>
    {{ samples }}
  </pre>
</template>

<script setup lang="ts">
import { defineProps } from 'vue'
import openbis from '~/app/composables/openbis.esm'

const props = defineProps<{
  samples: openbis.Sample[]
}>()

const headers = [
  { title: 'Sample Code', value: 'code' },
  { title: 'Registration Date', value: 'registrationDate' },
  { title: 'Modification Date', value: 'modificationDate' },
  { title: 'Properties', value: 'properties' },
]

const itemKey = 'id'
</script>

<style scoped>
</style>
