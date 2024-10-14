<template>
    <div>
      <h1>TEST Vocabulary Terms</h1>
      <ul>
        <li v-for="term in testVocabularyTerms" :key="term.getCode()">
          {{ term.getCode() }} - {{ term.getLabel() }}
        </li>
      </ul>
    </div>
</template>

<script setup lang="ts">
import { listVocabularyTermsByVocabularyCode } from '@/composables/api-connector/vocabularies';
import type openbis from '~/composables/openbis.esm';

const testVocabularyTerms = ref<openbis.VocabularyTerm[]>([]);

// Fetch terms from the "TEST" vocabulary
const fetchTestVocabularyTerms = async () => {
  try {
    testVocabularyTerms.value = await listVocabularyTermsByVocabularyCode('TEST');
  } catch (error) {
    console.error('Failed to fetch TEST vocabulary terms:', error);
  }
};

// Call the function to fetch TEST vocabulary terms when the component is mounted
fetchTestVocabularyTerms();

</script>
