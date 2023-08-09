<script setup lang="ts">
const { searchTerm } = defineProps<{ searchTerm: string }>()
</script>

<template>
  <v-row>
    <APIComponentsAutocompleteVocabulary :search-term="searchTerm" />
    <v-spacer />
    <APIComponentsAddVocabularyTerm :search-term="searchTerm" />
  </v-row>
</template>
