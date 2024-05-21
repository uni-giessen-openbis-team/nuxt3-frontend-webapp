<script setup lang="ts">
import { ref } from 'vue'
import { useProjectEntitiesStore } from '@/store/projectEntities';

const  modelValue  = defineModel<{ modelValue: Array<Object> }>()

const tab = ref('')

const store = useProjectEntitiesStore();
const variables = store.variables;
</script>

<template>
  <v-autocomplete
    v-model="modelValue"
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
        <v-tab v-for="(item, index) in modelValue" :key="index" :value="item.title">
          {{ item.title }}
        </v-tab>
      </v-tabs>
      <v-card-text>
        <v-window v-model="tab">
          <v-window-item v-for="(item, index) in modelValue" :key="index" :value="item.title">
            <div v-if="item.title === 'species'">
              <APIComponentsAutocompleteVocabulary
                v-model="item.conditions"
                search-term="NCBI_TAXONOMY"
              />
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
  <pre>{{ modelValue }}</pre>
</template>

<style lang="scss" scoped>

</style>
