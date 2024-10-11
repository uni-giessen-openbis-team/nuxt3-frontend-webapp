
<script setup lang="ts">
import { ref } from 'vue'
import WizardSelectProperties from './SelectProperties.vue'
import type { Property } from '@/types/wizard'
// This is some small view component, where the selectedProperties are created. and later passed to the parent

const selectedProperties = ref<Property[]>([])
const props = defineProps<{
  items: Array<Property>; // Adjust the type as necessary
}>()

const tab = ref('')
</script>

<template>
<div/>
  <WizardSelectProperties  :items="props.items" @update:selected-properties="selectedProperties = $event"/>

  <v-card>
    <v-tabs v-model="tab" bg-color="primary">
      <v-tab v-for="(item, index) in selectedProperties" :key="index" :value="item.title">
        {{ item.title }}
      </v-tab>
    </v-tabs>
    <v-card-text>
      <v-window v-model="tab">
        <v-window-item v-for="(item, index) in selectedProperties" :key="index" :value="item.title">
            <WizardPropertyValuesInput :property="item"/>
        </v-window-item>
      </v-window>
    </v-card-text>
  </v-card>
</template>
