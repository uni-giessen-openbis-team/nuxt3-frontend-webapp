<template>
  <v-container>
    <v-row>
      <v-col
        v-for="experiment in experiments"
        :key="experiment.permId.permId"
        cols="12"
        sm="6"
        md="4"
      >
        <v-card class="experiment-card" @click="goToCollection(experiment.permId.permId)">
          <v-card-title>{{ experiment.code }}</v-card-title>
          <v-card-subtitle>{{ experiment.description }}</v-card-subtitle>
        </v-card>
      </v-col>
    </v-row>
    <v-alert v-if="error" type="error">
      {{ error.message }}
    </v-alert>
  </v-container>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const experiments = ref([])
const error = ref(null)
const router = useRouter()
const experimentStore = useCollectionStore()

const fetchCollections = async () => {
  try {
    experiments.value = await experimentStore.listAllCollections()
  } catch (err) {
    error.value = err
  }
}

const goToCollection = (permId: string) => {
  router.push(`/experiments/${permId}`)
}

onMounted(fetchCollections)
</script>

<style scoped>
.experiment-card {
  cursor: pointer;
  transition: transform 0.2s;
}
.experiment-card:hover {
  transform: scale(1.05);
}
</style>