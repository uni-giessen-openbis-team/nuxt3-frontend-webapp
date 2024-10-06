<script setup lang="ts">
import type { EntitySampleHandler, BiologicalSampleHandler, TechnicalSampleHandler } from '~/composables/SampleHandlerClass';
import type { PropertyWithVocabularyCode } from '~/composables/PropertiesClass';

// Define modelValue using defineModel
const modelValue = defineModel<Ref<EntitySampleHandler | BiologicalSampleHandler | TechnicalSampleHandler>>();

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
    <div v-if="modelValue?.value">
      <v-combobox
        v-model="modelValue.value.properties"
        label="Properties"
        box
        chips
        multiple
        return-object
        class="mt-4"
        :items="modelValue.value.items" 
      />
    </div>
  </div>
  <div>
    <v-card>
      <v-tabs v-model="tab" bg-color="primary">
        <v-tab v-for="(item, index) in modelValue?.value.properties" :key="index" :value="index">
          {{ item.title }}
        </v-tab>
      </v-tabs>
      <v-card-text>
        <v-window v-model="tab">
          <v-window-item v-for="(item, index) in modelValue?.value.properties" :key="index" :value="index">
            <div v-if="isPropertyWithVocabularyCode(item)">
              <v-autocomplete
                v-model="item.conditions"
                :items="item.vocabularyTerms"
                multiple
              />
            
              <v-alert v-if="item.vocabularyTerms.length === 0" type="error">
                No vocabulary terms available.
              </v-alert>
            </div>
            <div v-else>
              <WizardCrudTable v-model="item.conditions" />
              <v-checkbox
                v-model="item.continuous"
                label="continuous"
              />

              <div v-if="item.continuous === true">
                Unit
                <v-text-field v-model="item.unit" />
              </div>
            </div>
          </v-window-item>
        </v-window>
      </v-card-text>
    </v-card>
    <h3>Properties</h3>
    <pre>{{ modelValue?.value.properties }}</pre>
    <h3>propertyCombinations</h3>
    <pre>{{ modelValue?.value.propertyCombinations }}</pre>
    <h3>sampleCreations</h3>
    <pre>{{ modelValue?.value.sampleCreations }}</pre>
    <h3>PARENT</h3>
    <pre>{{ modelValue?.value.parentSampleHandler }}</pre>\


  </div>
</template>