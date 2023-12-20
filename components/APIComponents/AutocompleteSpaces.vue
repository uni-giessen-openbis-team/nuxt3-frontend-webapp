<script setup lang="ts">
import { useOpenBisStore } from '@/composables/openbisAPI'
const store = useOpenBisStore()

const { space } = defineModels<{ space }>()

const projectSpaces = ref<string[]>([])

onMounted(async () => {
  // Load the spaces from the API
  const spaces = await store.getAllSpaces()
  projectSpaces.value = spaces.objects.map(space => space.code)
})
</script>

<template>
  <v-autocomplete
    v-model="space"
    :items="projectSpaces"
    label="Project-Space"
    :rules="[value => !!value || 'Item is required']"
  />
</template>
