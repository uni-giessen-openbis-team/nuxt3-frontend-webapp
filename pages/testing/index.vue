<script setup lang="ts">
const conditions = ref([])
</script>

<template>
  <div>
    <APIComponentsAutocompleteVocabulary
      v-model="conditions"
      search-term="NCBI_TAXONOMY"
    />
  </div>
</template>
