<script setup lang="ts">
import { ref, onMounted } from 'vue';
import type   openbis from '~/composables/openbis.esm';
const props = defineProps<{
  vocabularyCode: string;
}>();

const vocabulary = ref<openbis.Vocabulary | null>(null);
const newTermCode = ref('');
const newTermLabel = ref('');
const errorMessage = ref('');

onMounted(async () => {
  await loadVocabulary();
});

async function loadVocabulary() {
  try {
    vocabulary.value = await vocabulary.load(props.vocabularyCode);
  } catch (error) {
    console.error('Error loading vocabulary:', error);
    errorMessage.value = 'Failed to load vocabulary. Please try again.';
  }
}

function createVocabularyTermCreation() {
  if (!newTermCode.value || !vocabulary.value) return;

  try {
    const label = newTermLabel.value || newTermCode.value; // Use label if provided, otherwise use code
    const creation = vocabulary.value.addTerm(newTermCode.value, label);
    console.log('VocabularyTermCreation object created:', creation);
    
    // Here you would typically send this creation object to your API
    // The term has already been added to the local list in the addTerm method

    newTermCode.value = '';
    newTermLabel.value = '';
  } catch (error) {
    console.error('Error creating VocabularyTermCreation object:', error);
    errorMessage.value = 'Failed to create new term. Please try again.';
  }
}
</script>

<template>
  <div>
    <h2>{{ vocabulary?.getCode() }}</h2>
    <v-text-field
      v-model="newTermCode"
      label="New Term Code"
      @keyup.enter="createVocabularyTermCreation"
    />
    <v-text-field
      v-model="newTermLabel"
      label="New Term Label (optional)"
      @keyup.enter="createVocabularyTermCreation"
    >
      <template #append>
        <v-btn
          :disabled="!newTermCode"
          icon
          @click="createVocabularyTermCreation"
        >
          <v-icon>mdi-plus</v-icon>
        </v-btn>
      </template>
    </v-text-field>
    <v-list>
      <v-list-item v-for="term in vocabulary?.terms" :key="term.code">
        {{ term.getLabel() }} ({{ term.getCode() }})
      </v-list-item>
    </v-list>
    <v-alert v-if="errorMessage" type="error">{{ errorMessage }}</v-alert>
  </div>
</template>
