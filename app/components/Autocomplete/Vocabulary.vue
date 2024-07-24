<script setup lang="ts">
import type  openbis from '~/composables/openbis.esm'

const { searchTerm } = defineProps<{
  searchTerm: string
}>()

const  modelValue = defineModel<{ modelValue: string[] }>()
const vocabularyTerms = ref<openbis.VocabularyTerm[]>([])

onMounted(async () => {
   vocabularyTerms.value = await useVocabularyStore().listVocabularyTermsByVocabularyCode(searchTerm)
}) 

</script>

<template>
  <div v-if="vocabularyTerms.length > 0">
  <v-autocomplete
    v-model="modelValue"
    :items="vocabularyTerms"
    item-title="label"
  />
</div>

</template>
