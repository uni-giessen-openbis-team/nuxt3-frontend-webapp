<script setup lang="ts">
import type openbis from '~/composables/openbis.esm';

const { searchTerm } = defineProps<{
  searchTerm: string
}>()

const selectedVocabulary = defineModel<openbis.VocabularyTerm[]>('selectedVocabulary', { default: () => [] })

const vocabularyTerms = ref<openbis.VocabularyTerm[]>([])

onMounted(async () => {
  vocabularyTerms.value = await listVocabularyTermsByVocabularyCode(searchTerm)
})

</script>

<template>
  <div v-if="vocabularyTerms.length > 0">
    <v-autocomplete 
      v-model="selectedVocabulary" 
      :items="vocabularyTerms" 
      item-title="code" 
      :return-object="true"
      multiple 
    />
  </div>  
  <pre>{{ JSON.stringify(selectedVocabulary, null, 2) }}</pre>
</template>
