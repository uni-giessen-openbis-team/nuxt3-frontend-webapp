<script setup lang="ts">

/**
 * This is the second step of the Wizzard.
 * Here the user can select the variables that describe the differences between the biological entities.
 * These variables will be later combined with the samples by the Wizzard to create the project.
 */

import openbis from '@/composables/openbis.esm'

const { biologicalSampleVariables: variables, entityVariables: entetyVariables } = storeToRefs(useWizzardStore())

const allVocabularies = ref<openbis.Vocabulary[]>([])

const tab = ref('')

onMounted(async () => {
  allVocabularies.value = await useVocabularyStore().listAllVocabularies()
})


</script>

<template>
  <div> 
    What are the differences between the biological enteties. 
    The enteties can be something like a tree. Select one or 
    more variables that describe the differences between the enteties.

    If the value is a continous value like hight of the tree, please select continuous and
    select the unit of the value.
  </div>
  <br>
  <v-combobox
    v-model="entetyVariables"
    label="Experimental variables"
    box
    chips
    :items="variables" 
    multiple
    return-object
    
  />
  <div>
    <v-card>
      <v-tabs v-model="tab" bg-color="primary">
        <v-tab v-for="(item, index) in entetyVariables" :key="index" :value="item.title">
          {{ item.title }}
        </v-tab>
      </v-tabs>
      <v-card-text>
        <v-window v-model="tab">
          <v-window-item v-for="(item, index) in entetyVariables" :key="index" :value="item.title">
            <div v-if="item.vocabularyCode !== ''">
              <!-- Todo: Add APIComponentsAutocompleteVocabulary -->
              <div>
                <label for="species-selector">Select Species:</label>
                <AutocompleteVocabulary :searchTerm="item.vocabularyCode" v-model="item.conditions[0]" />
              </div>
            </div>
            
            <div v-else>
              <WizzardCrudTable v-model="item.conditions" />

              <v-checkbox
                v-model="item.continous"
                label="continous"
              />

              <div v-if="item.continous === true">
                Unit
                <v-text-field v-model="item.unit" />
              </div>
            </div>
          </v-window-item>
        </v-window>
      </v-card-text>
    </v-card>
  </div>
  <pre>

    {{entetyVariables}}
  </pre>
</template>

<style lang="scss" scoped>

</style>
