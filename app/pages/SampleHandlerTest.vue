<template>
  <div>
    <h1>Sample Handler Test</h1>
    // First lets test the  EntitySampleHandler.
    // select conditions and create entities.

    <div>
      <h2>Select Conditions</h2>
      <AutocompleteVocabulary
        v-model="entitySampleHandler.conditions"
        search-term="$STORAGE_FORMAT"
      />
    </div>
  </div>
</template>

<script lang="ts" setup>
import type { ProjectContext } from '../types/wizard';
// Load some entities. Enteties are created by selecting conditions 
// and let them transform into entities.
const projectContext: ProjectContext = {
  spaceCode: "DEFAULT", projectCode: "DEFAULT", experimentCode: "DEFAULT",
  contactPerson: null,
  manager: null,
  description: null
}
// create a new entitySampleHandler with an empty entityVariables array.
const entitySampleHandler = new EntitySampleHandler(projectContext)

// This array needs to be filled with entities. Enteties are created by selecting conditions



</script>

