<script setup lang="ts">
import type { PropertyWithoutVocabularyCode } from '~/composables/PropertiesClass';

defineProps<{
  property: PropertyWithoutVocabularyCode
}>();
</script>

<template>
  <div class="property-without-vocabulary-code-editor">
    <WizardCrudTable v-model="property.conditions" />
    <v-checkbox
      v-model="property.continuous"
      label="Continuous"
    />  
    <div v-if="property.continuous">
      <label>Unit</label>
      <v-text-field v-model="property.unit" />
    </div>
  </div>
</template>