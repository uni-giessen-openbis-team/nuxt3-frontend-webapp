<script setup lang="ts">
import { PropertyWithVocabularyCode } from '~/composables/PropertiesClass';

defineProps<{
  property: PropertyWithVocabularyCode
}>();
</script>

<template>
  <div class="property-with-vocabulary-code-editor">
    <label :for="`${property.title}-selector`">Select {{ property.title }}:</label>
    <AutocompleteVocabulary 
      v-model="property.conditions[0]" 
      :search-term="property.vocabularyCode" 
    />
  </div>
</template>