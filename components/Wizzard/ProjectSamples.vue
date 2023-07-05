<script setup lang="ts">
import { ref } from 'vue'

const { modelValue } = defineModels<{ modelValue: Object }>()

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
</script>

<template>
  <v-autocomplete
    v-model="modelValue.tableVariables"
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
        <v-tab v-for="(item, index) in modelValue.tableVariables" :key="index" :value="item.title">
          {{ item.title }}
        </v-tab>
      </v-tabs>
      <v-card-text>
        <v-window v-model="tab">
          <v-window-item v-for="(item, index) in modelValue.tableVariables" :key="index" :value="item.title">
            <div>
              <WizzardCrudTable v-model="item.conditions" />
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
