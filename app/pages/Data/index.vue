f<template>
  <v-container>
    <v-row>
      <v-col cols="12">
        <v-card @click="goToSpaces" class="data-card">
          <v-card-title>Spaces</v-card-title>
          <v-card-subtitle>View and manage all spaces</v-card-subtitle>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script setup>
import { useRouter } from 'vue-router'

const router = useRouter()

const goToSpaces = () => {
  router.push('/data/spaces')
}
</script>

<style scoped>
.data-card {
  cursor: pointer;
  transition: transform 0.2s;
}

.data-card:hover {
  transform: scale(1.05);
}
</style>