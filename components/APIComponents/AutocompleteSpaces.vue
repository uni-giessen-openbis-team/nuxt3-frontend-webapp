<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI'
import { useUserSettingsStore } from '@/composables/stores/userSettingsStore'

const openBisStore = useOpenBisStore()
const settingsStore = useUserSettingsStore()

// Set the initial value of space from the userSettingsStore
const { space } = defineModels<{ space: any }>()

const projectSpaces = ref<string[]>([])

const onSpaceChange = (newSpace: string) => {
  emit('update:space', newSpace)
}

onMounted(async () => {
  console.log('mounted autocompleteSpaces')
  const spaces = await openBisStore.getAllSpaces()
  projectSpaces.value = spaces.objects.map(space => space.code)
  space.value = settingsStore.selectedSpace
})
</script>

<template>
  <v-autocomplete
    v-model="space"
    :items="projectSpaces"
    label="Project-Space"
    :rules="[value => !!value || 'Item is required']"
    @change="onSpaceChange"
  />
</template>
