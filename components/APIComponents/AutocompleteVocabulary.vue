<script setup lang="ts">
import openbis from '@/composables/openbis.esm'
const { searchTerm } = defineProps<{
  searchTerm: string
}>()

const { modelValue } = defineModels<{ modelValue: string[] }>()

const vocabularyTermList = ref([])
onMounted(async () => {
  const vocabularyTerms = await useVocabularyStore().getVocabulary(
    new openbis.VocabularyPermId(searchTerm),
  )
  console.log('🚀 ~ onMounted ~ vocabularyTerms:', vocabularyTerms)
  vocabularyTermList.value = vocabularyTerms
})
</script>

<template>
  <v-autocomplete
    v-model="modelValue"
    :items="vocabularyTermList"
    multiple
  />
</template>
