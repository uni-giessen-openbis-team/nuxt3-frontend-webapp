<script setup lang="ts">

import { useRouter } from 'vue-router'
import openbis from '~/app/composables/openbis.esm'


const datasets = ref<openbis.DataSet[]>([])
const error = ref(null)
const router = useRouter()
const datasetStore = useDatasetStore()

const fetchDatasets = async () => {
  try {
    console.log('Fetching all datasets')
    datasets.value = await datasetStore.listAllDataSets()
    console.log('Fetched datasets:', datasets.value)
  } catch (err) {
    console.error('Error fetching datasets:', err)
    error.value = err
  }
}

const goToDataset = (permId: string) => {
  router.push(`/datasets/${permId}`)
}

onMounted(fetchDatasets)
</script>

<template>
  <v-container>

    <v-row>
      <v-col
        v-for="dataset in datasets"
        :key="dataset.permId.permId"
        cols="12"
        sm="6"
        md="4"
      >
        <v-card @click="goToDataset(dataset.permId.permId)" class="dataset-card">
          <v-card-title>{{ dataset.getCode()  }}</v-card-title>
          <v-card-subtitle>{{ dataset.getType() }}</v-card-subtitle>
          {{  dataset.getDataStore()}}
        </v-card>
      </v-col>
    </v-row>
    <v-alert v-if="error" type="error">
      {{ error.message }}
    </v-alert>
  </v-container>
</template>



<style scoped>
.dataset-card {
  cursor: pointer;
  transition: transform 0.2s;
}
.dataset-card:hover {
  transform: scale(1.05);
}
</style>
