<script setup lang="ts">

const { searchTerm } = defineProps<{
  // descructuring props
  searchTerm: string
}>()

const store = useOpenBisStore()

const { modelValue } = defineModels<{ modelValue: string[] }>()

const speciesList = ref([])
onMounted(async () => {
  const jsonObject = await useVocabularyStore().getVocabularyTerms( store.v3.vocabularyPermId(searchTerm))
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
