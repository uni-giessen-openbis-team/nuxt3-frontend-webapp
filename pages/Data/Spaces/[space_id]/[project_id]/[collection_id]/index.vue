<template>
  <v-container>
    <v-row>
      <v-col
        v-for="collection in collections"
        :key="collection.getPermId().toString()"
        cols="12"
        sm="6"
        md="4"
      >
        <v-card @click="goToCollection(collection.getPermId())" class="collection-card">
          <v-card-title>{{ collection.getCode() }}</v-card-title>
          <v-card-subtitle>{{ collection.description }}</v-card-subtitle>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import openbis from '~/composables/openbis.esm';

const collectionStore = useCollectionStore()
const collections = ref<openbis.Experiment[]>([])
const router = useRouter()
const route = useRoute()
const projectId = route.params.project_id as string

const fetchCollections = async () => {
  collections.value = await collectionStore.listCollectionsOfProject({ permId: projectId })
}

const goToCollection = (permId: openbis.ExperimentPermId) => {
  router.push(`/collections/${permId}`)
}

onMounted(fetchCollections)
</script>

<style scoped>
.collection-card {
  cursor: pointer;
  transition: transform 0.2s;
}
.collection-card:hover {
  transform: scale(1.05);
}
</style>