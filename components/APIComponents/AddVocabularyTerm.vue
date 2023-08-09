<script setup lang="ts">
import { useOpenBisStore } from '@/composables/openbisAPI'
import { bus } from '@/composables/event-bus'

const { searchTerm } = defineProps<{ searchTerm: string }>()

const store = useOpenBisStore()
const newSpecies = ref('')

async function addSpecies() {
  const createdSpeciesNameResult = await store.createVocabularyTermByVocabulary(searchTerm, newSpecies.value)
  console.info(`${createdSpeciesNameResult} created`)
  newSpecies.value = '' // Reset the input after creation
  await nextTick()

  // fire an event
  bus.emit('vocabulary-term-added')
}
</script>

<template>
  <v-text-field
    v-model="newSpecies"
    label="Add new Entry"
    append-inner-icon=" mdi-upload "
    @click:append-inner="addSpecies"
  />

  <pre>
    {{ newSpecies }}
  </pre>
</template>
