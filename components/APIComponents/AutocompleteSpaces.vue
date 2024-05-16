<script setup lang="ts">
const store = useSpaceStore()

const space = defineModel<{ space: string }>()

const projectSpaces = ref<string[]>([])

onMounted(async () => {
  // Load the spaces from the API
  const spaces = await store.getAllSpaces()
  console.log('🚀 ~ onMounted ~ spaces:', JSON.stringify(spaces))
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
