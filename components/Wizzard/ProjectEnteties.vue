<script setup lang="ts">
import { ref } from 'vue'
import { useOpenBisStore } from '@/composables/openbisAPI.js'
const store = useOpenBisStore()
const { modelValue } = defineModels<{ modelValue: Array<Object> }>()

const tab = ref('')

const variables = ref([
  {
    title: 'genotype',
    conditions: ref([]),
    continous: false,
    unit: null,
  }, {
    title: 'color',
    conditions: ref([]),
    continous: false,
    unit: null,
  },
])

const jsonObject = await store.getVocabularyTerms('SPECIES')
const speciesList = jsonObject.SPECIES.terms.map(term => term.label)
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
              <v-autocomplete
                v-model="item.conditions"
                :items="speciesList"
                multiple
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
