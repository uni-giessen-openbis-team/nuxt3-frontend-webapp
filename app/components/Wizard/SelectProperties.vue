<script setup lang="ts">
import type { Property } from '@/types/wizard'

import type openbis from '~/composables/openbis.esm'

const tab = ref('')

const props = defineProps<{
  items: Array<Property>; // Adjust the type as necessary
}>()

onMounted(async () => {
  allVocabularies.value = await listAllVocabularies()
})


const selectedProperties = ref<Property[]>([])

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
  <v-combobox v-model="selectedProperties" label="Experimental variables" box chips :items="props.items" multiple
    return-object />
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
              <v-checkbox v-model="item.continuous" label="continuous" />
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
</template>