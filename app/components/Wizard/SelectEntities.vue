<script setup lang="ts">
import type { PropertyWithVocabularyCode, PropertyWithoutVocabularyCode } from '~/composables/PropertiesClass';


// Define modelValue using defineModel
const modelValue = defineModel<(PropertyWithVocabularyCode | PropertyWithoutVocabularyCode)[]>();

const props = defineProps<{
  items: (PropertyWithVocabularyCode | PropertyWithoutVocabularyCode)[] | undefined;
}>();


const tab = ref(0);

function isPropertyWithVocabularyCode(item: unknown): item is PropertyWithVocabularyCode {
  return typeof item === 'object' && item !== null && 'vocabularyCode' in item;
}


</script>

<template>
  <div class="select-entities">
    <slot name="description">
      Here you can select the properties.
    </slot>
    <div v-if="props.items && props.items.length">
      <v-combobox v-model="modelValue" label="Properties" box chips multiple return-object class="mt-4"
        :items="props.items" />
    </div>
  </div>

  <v-card>
    <v-tabs v-model="tab" bg-color="primary">
      <v-tab v-for="(item, index) in modelValue" :key="index" :value="index">
        {{ item.title }}
      </v-tab>
    </v-tabs>
    <v-card-text>
      <v-window v-model="tab">
        <v-window-item v-for="(item, index) in modelValue" :key="index" :value="index">
          <div v-if="isPropertyWithVocabularyCode(item)">
            <v-autocomplete v-model="item.conditions" :items="item.vocabularyTerms" multiple />

            <v-alert v-if="item.vocabularyTerms.length === 0" type="error">
              No vocabulary terms available.
            </v-alert>
          </div>
          <div v-else>
            <WizardCrudTable v-model="item.conditions" />
            <v-checkbox v-model="item.continuous" label="continuous" />

            <div v-if="item.continuous === true">
              Unit
              <v-text-field v-model="item.unit" />
            </div>
          </div>
        </v-window-item>
      </v-window>
    </v-card-text>
  </v-card>
</template>