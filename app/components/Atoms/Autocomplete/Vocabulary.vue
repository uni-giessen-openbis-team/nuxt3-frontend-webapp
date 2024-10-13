<script setup lang="ts">
import { VAutocomplete } from 'vuetify/components';
import type openbis from '~/composables/openbis.esm';
import type { VocabularyTerm } from '~/types/wizard';

const { searchTerm } = defineProps<{
  searchTerm: string
}>()
const emit = defineEmits<{
  (e: 'update:selectedVocabulary', value: VocabularyTerm[]): void
}>()

const selectedVocabulary = ref<openbis.VocabularyTerm[]>([])
const vocabularyTerms = ref<openbis.VocabularyTerm[]>([])

onMounted(async () => {
  vocabularyTerms.value = await listVocabularyTermsByVocabularyCode(searchTerm) || []
})

// Computed property to transform selected vocabulary
const _selectedVocabulary  = computed(() => {
  return selectedVocabulary.value.map(term => ({
    title: term.getLabel() || '',
    description: term.getDescription() || '',
    code: term.getCode() || ''
  }));
});

// Watch the computed property and emit the transformed value
watch(_selectedVocabulary, (newValue) => {
  emit('update:selectedVocabulary', newValue);
});

</script>

<template>
{{  vocabularyTerms[0]?.getVocabulary().getDescription() }}  
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
