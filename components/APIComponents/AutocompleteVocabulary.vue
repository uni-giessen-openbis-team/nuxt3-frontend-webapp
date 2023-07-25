<script setup lang="ts">
import { onMounted } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI'

const { searchTerm } = defineProps<{
  // descructuring props
  searchTerm: string
}>()

const { modelValue } = defineModels<{ modelValue: string[] }>()

const store = useOpenBisStore()
const speciesList = ref([])
onMounted(async () => {
  const jsonObject = await store.getVocabularyTerms(searchTerm)
  console.log('🚀 ~ file: AutocompleteVocabulary.vue:16 ~ onMounted ~  jsonObject:', jsonObject)
  speciesList.value = jsonObject[searchTerm].terms.map(term => term.label)
})
</script>

<template>
  <v-autocomplete
    v-model="modelValue"
    :items="speciesList"
    multiple
  />
</template>
