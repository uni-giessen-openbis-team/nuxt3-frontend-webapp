<script setup lang="ts">
import { ref, onMounted } from 'vue';
import type openbis from '~/composables/openbis.esm';
// Define your model
const space = ref<openbis.Space>({});
const spaces = ref<openbis.Space[]>([]);

onMounted(async () => {
  // Load the spaces from the API
  spaces.value = await getAllSpaces();
  console.log('🚀 ~ onMounted ~ spaces:', JSON.stringify(spaces.value));

});
</script>

<template>
 
 <v-autocomplete
      v-model="space"
      :items="spaces"
      label="Project-Space"
      :rules="[value => !!value || 'Item is required']"
      item-title="code"
      :return-object="true"
    />
</template>