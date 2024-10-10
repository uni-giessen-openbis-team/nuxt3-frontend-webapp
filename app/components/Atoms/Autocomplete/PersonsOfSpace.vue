<script setup lang="ts">
// TODO: add type spaceCode
import { onMounted, ref } from 'vue'
const { space = 'DEFAULT' } = defineProps<{
  space: spaceCode
}>()

const  modelValue = defineModel<{ modelValue: any }>()

const store = useOpenBisStore()
const projectPersons = ref<string[]>([])

onMounted(async () => {
  // Load the persons from the API
  const persons = await store.listPersonsOfSpace(space)
  projectPersons.value = await persons.objects.map((person: { code: string }) => person.code)
})
</script>

<template>
  <v-autocomplete
    v-model="modelValue"
    :items="projectPersons"
    label="Project-person"
    :rules="[(value: any) => !!value || 'Item is required']"
  />
</template>
