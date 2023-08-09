<script setup lang="ts">
const conditions = ref([])
</script>

<template>
  <div>
    <v-container>
      <WizzardAddAndSelectVocabularyTerm
        v-model="conditions"
        search-term="NCBI_TAXONOMY"
      />
    </v-container>
  </div>
</template>
