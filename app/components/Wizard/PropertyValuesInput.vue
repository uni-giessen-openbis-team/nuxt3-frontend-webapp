<script setup lang="ts">
import type { PropertyWithVocabulary , Condition } from '@/types/wizard'

// Prop goes in and decides which one of the below is shown
const property = defineModel<PropertyWithVocabulary>('property', { required: true })

function handleListUpdate(updatedList: Condition[]) {
    property.value.conditions = updatedList
}
</script>

<template>
    <div v-if="property.vocabularyCode && property.vocabularyCode !== ''">
        <div>
            <label for="species-selector">Select Species:</label>
            <AutocompleteVocabulary :search-term="property.vocabularyCode as string"/>
        </div>
    </div>
    <div >
        <WizardTextareaToList @update:list="handleListUpdate" />
        <WizardAddUnitToProperty v-model:continuous="property.continuous" v-model:="property.unit" />
    </div>
</template>