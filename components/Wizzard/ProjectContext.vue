<script setup lang = "ts">
import { onMounted, ref } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI.js'

const MINDESCLENGTH = 20

const { modelValue } = defineModels<{ modelValue: Object }>()

// data from the API
const store = useOpenBisStore()
const people = ref([])
const projectSpaces = ref([])

onMounted(async () => {
  // Load the spaces from the API
  const SpaceSearchCriteria = store.loadedResources.SpaceSearchCriteria
  const SpaceFetchOptions = store.loadedResources.SpaceFetchOptions
  const criteria = new SpaceSearchCriteria()
  const fo = new SpaceFetchOptions()
  const spaces = await store.searchSpaces(criteria, fo)
  projectSpaces.value = spaces.objects.map(space => space.code)
})
</script>

<template>
  <div>
    <v-autocomplete
      v-model="modelValue.space"
      :items="projectSpaces"
      label="Project-Space"
      :rules="[value => !!value || 'Item is required']"
    />

    <v-text-field
      v-model="modelValue.name"
      label="New Project Name"
      :rules="[value => !!value || 'Item is required']"
    />

    <v-autocomplete
      v-model="modelValue.contactPerson"
      :items="people"
      label="Contact Person"
    />

    <v-autocomplete
      v-model="modelValue.manager"
      :items="people"
      label="Project Manager"
    />

    <v-textarea
      v-model="modelValue.description"
      :counter="2000"
      label="Description"
      :rules="[value => !!value || 'Item is required', value => (value && value.length >= MINDESCLENGTH) || 'Item must be at least 20 characters']"
    />
  </div>
  Iside projectContext.vue
  <pre>{{ modelValue }}</pre>
</template>
