<script setup lang="ts">
// This comp
import { ref } from 'vue'
import type { TableVariable } from '@/types/wizard'

const modelValue  = defineModel()
const tab = ref('')

const variables: Ref<TableVariable[]> = ref([
  {
    title: 'Growth Medium',
    conditions: ref([]),
    continuous: false,
    unit: null,
    vocabularyCode: null,
  }, {
    title: 'Treatment',
    conditions: ref([]),
    continuous: false, 
    unit: null,
    vocabularyCode: null,
  },
])

// const jsonObject = await store.getVocabularyTerms('TISSUES')
// const tissues = jsonObject.TISSUES?.terms.map(term => term.label)
const tissues = ['tissue1', 'tissue2']
</script>

<template>
  <div>
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
              <div v-if="item.title === 'tissue'">
                <v-autocomplete
                  v-model="item.conditions"
                  :items="tissues"
                  multiple
                />
              </div>
              <div v-else>
                <WizardCrudTable v-model="item.conditions" />

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
  </div>
</template>

<style lang="scss" scoped>

</style>
