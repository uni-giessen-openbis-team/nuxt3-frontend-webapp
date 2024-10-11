<script setup lang="ts">
import { VAutocomplete } from 'vuetify/components';
import type openbis from '~/composables/openbis.esm';

const { searchTerm } = defineProps<{
  searchTerm: string
}>()
const emit = defineEmits<{
  (e: 'update:selectedVocabulary', value: openbis.VocabularyTerm[]): void
}>()

const selectedVocabulary = ref<openbis.VocabularyTerm[]>([])
const vocabularyTerms = ref<openbis.VocabularyTerm[]>([])

onMounted(async () => {
  vocabularyTerms.value = await listVocabularyTermsByVocabularyCode(searchTerm) || []
})

// Add a watcher for selectedVocabulary
watch(selectedVocabulary, (newValue) => {
  emit('update:selectedVocabulary', newValue)
})

</script>

<template>
  <div v-if="vocabularyTerms.length > 0">
    <VAutocomplete
      v-model="selectedVocabulary" 
      :items="vocabularyTerms" 
      item-title="code" 
      :return-object="true"
      multiple 
    />
  </div>  
</template>
