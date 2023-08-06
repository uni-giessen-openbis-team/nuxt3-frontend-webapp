<script setup lang="ts">
// TODO: add type spaceCode
import { onMounted, ref } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI'
const { space = 'DEFAULT' } = defineProps<{
  space: spaceCode
}>()
const { person } = defineModels<{ person: any }>()

const store = useOpenBisStore()
const projectPersons = ref<string[]>([])

onMounted(async () => {
  // Load the persons from the API
  const persons = await store.listPersonsOfSpace(space)
  projectPersons.value = persons.objects.map((person: { code: string }) => person.code)
})
</script>

<template>
  <v-autocomplete
    v-model="person"
    :items="projectPersons"
    label="Project-person"
    :rules="[(value: any) => !!value || 'Item is required']"
  />
</template>
