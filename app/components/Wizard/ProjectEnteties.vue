<script setup lang="ts">
/**
 * This is the second step of the Wizard.
 * Here the user can select the variables that describe the differences between the biological entities.
 * These variables will be later combined with the samples by the Wizard to create the project.
 */

import type openbis from '~/composables/openbis.esm'

const { biologicalSampleVariables: variables, entityVariables: entetyVariables } = storeToRefs(useWizardStore())

const allVocabularies = ref<openbis.Vocabulary[]>([])
const tab = ref('')

onMounted(async () => {
  allVocabularies.value = await listAllVocabularies()
})

const formattedEntityVariables = computed({
  get() {
    return entetyVariables.value.map(item => {
      if (typeof item === 'string') {
        return {
          title: item,
          conditions: [],
          continuous: false,
          unit: null,
          vocabularyCode: ""
        }
      }
      return item
    })
  },
  set(newValue) {
    entetyVariables.value = newValue
  }
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
    v-model="formattedEntityVariables"
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
        <v-tab v-for="(item, index) in formattedEntityVariables" :key="index" :value="item.title">
          {{ item.title }}
        </v-tab>
      </v-tabs>
      <v-card-text>
        <v-window v-model="tab">
          <v-window-item v-for="(item, index) in formattedEntityVariables" :key="index" :value="item.title">
            <div v-if="item.vocabularyCode !== ''">
              <!-- Todo: Add APIComponentsAutocompleteVocabulary -->
              <div>
                <label for="species-selector">Select Species:</label>
                <AutocompleteVocabulary v-model="item.conditions[0]" :search-term="item.vocabularyCode as string" />
              </div>
              {{ item }}
            </div>
            <div v-else>
              <WizardCrudTable v-model="item.conditions" />
              <v-checkbox
                v-model="item.continuous"
                label="continuous"
              />
              <div v-if="item.continuous">
                Unit
                <v-text-field v-model="item.unit" />
              </div>
            </div>
          </v-window-item>
        </v-window>
      </v-card-text>
    </v-card>
  </div>
  <pre>{{ formattedEntityVariables }}</pre>
</template>