<script setup lang="ts">
import { onMounted } from 'vue'

const store = useOpenBisStore()

onMounted(async () => {
  await store.loadV3API()
  await store.fetchSpaces()
})

const spacesCount = computed(() => store.spaces)
</script>

<template>
  <div>V3ConnectionExampleUsingESMBundle</div>
  <div>Number of spaces: {{ spacesCount }}</div>
</template>
