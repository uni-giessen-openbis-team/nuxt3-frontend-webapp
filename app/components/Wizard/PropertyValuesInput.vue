<script setup lang="ts">

import type { Property } from '@/types/wizard'

const props = defineProps<{
    property: Property;
}>()



</script>

<template>
    <div v-if="property.vocabularyCode !== ''">
        <!-- Todo: Add APIComponentsAutocompleteVocabulary -->
        <div>
            <label for="species-selector">Select Species:</label>
            <AutocompleteVocabulary v-model="property.conditions[0]" :search-term="property.vocabularyCode as string" />
        </div>
        {{ item }}
    </div>
    <div v-else>
        <WizardCrudTable v-model="item.conditions" />
        <v-checkbox v-model="property.continuous" label="continuous" />
        <div v-if="property.continuous">
            Unit
            <v-text-field v-model="property.unit" />
        </div>
    </div>
</template>