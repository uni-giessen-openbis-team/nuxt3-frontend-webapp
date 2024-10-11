<script setup lang="ts">
import type { Property , Condition } from '@/types/wizard'

// Prop goes in and decides which one of the below is shown
const property = defineModel<Property>('property', { required: true })

function handleListUpdate(updatedList: Condition[]) {
    property.value.conditions = updatedList
}
</script>

<template>
    <div v-if="property.vocabularyCode && property.vocabularyCode !== ''">
        <div>
            <label for="species-selector">Select Species:</label>
            <!-- Adjust the field name according to the actual structure of Property -->
            <AutocompleteVocabulary :search-term="property.vocabularyCode as string"/>
        </div>
    </div>
    <div v-else>
      
        <WizardTextareaToList @update:list="handleListUpdate" />
        <WizardAddUnitToProperty v-model:continuous="property.continuous" v-model:="property.unit" />
    </div>
</template>