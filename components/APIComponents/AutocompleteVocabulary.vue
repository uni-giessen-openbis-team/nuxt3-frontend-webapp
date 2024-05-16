<script setup lang="ts">
import openbis from '@/composables/openbis.esm'
const { searchTerm } = defineProps<{
  searchTerm: string
}>()

const  modelValue = defineModel<{ modelValue: string[] }>()

const vocabularyTermList = ref([])
onMounted(async () => {
  const vocabularyTerms = await useVocabularyStore().listVocabularyTermsByVocabularyCode(searchTerm)
})
</script>

<template>
  <v-autocomplete
    v-model="modelValue"
    :items="vocabularyTermList"
    multiple
  />
</template>
