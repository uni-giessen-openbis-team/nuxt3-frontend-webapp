<script setup lang="ts">
import { useUserSettingsStore } from '@/composables/stores/userSettingsStore'

const settingsStore = useUserSettingsStore()

const onSpaceSelected = (newSpace: string) => {
  settingsStore.setSelectedSpace(newSpace)
}
</script>

<template>
  <!-- Assuming APIComponent is registered and available for use here -->
  Select The Workspace
  <APIComponentsAutocompleteSpaces @update:space="onSpaceSelected" />
  <!-- Other settings related components and elements here -->
</template>
