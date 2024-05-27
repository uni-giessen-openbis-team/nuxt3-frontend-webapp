<template>
  <h1>Spaces</h1>
  <v-container>
    <v-row>
      <v-col
        v-for="space in spaces"
        :key="space.permId.permId"
        cols="12"
        sm="6"
        md="4"
      >
        <v-card @click="goToSpace(space.id)" class="space-card">
          <v-card-title>{{ space.code }}</v-card-title>
          <v-card-subtitle>{{ space.description }}</v-card-subtitle>
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
import openbis from '@/composables/openbis.esm';

const spaces = ref<openbis.Space[]>([])
const error = ref<Error | null>(null)
const router = useRouter()
const spaceStore = useSpaceStore()


const fetchSpaces = async () => {
  try {
    spaces.value = await spaceStore.getAllSpaces()
  } catch (err) {
    error.value = err as Error
  }
}

const goToSpace = (permId: string) => {
  router.push(`/data/spaces/${permId}`)
}

onMounted(fetchSpaces)
</script>

<style scoped>
.space-card {
  cursor: pointer;
  transition: transform 0.2s;
}
.space-card:hover {
  transform: scale(1.05);
}
</style>
