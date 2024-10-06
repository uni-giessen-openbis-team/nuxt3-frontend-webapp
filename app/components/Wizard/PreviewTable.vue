<script setup lang="ts">
import type { EntitySampleHandler, BiologicalSampleHandler, TechnicalSampleHandler } from '~/composables/SampleHandlerClass';

const modelValue = defineModel<Ref<EntitySampleHandler | BiologicalSampleHandler | TechnicalSampleHandler>>();

// extract the sampleCreations from the modelValue with toRefs
</script>

<template>
  <pre>{{ modelValue }}</pre>
  <v-table>
    <thead>
      <tr> 
        <th v-for="(key, index) in ['name', ...Object.keys(modelValue.value.sampleCreations[0]?.properties ?? {}).filter(k => !['name'].includes(k))]" :key="index">
          {{ key }}
        </th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="(item, index) in modelValue.value.sampleCreations" :key="index">
        <td v-for="key in ['name', ...Object.keys(item.properties).filter(k => !['name'].includes(k))]" :key="key">
          <template v-if="['count', 'name'].includes(key)">
            <v-text-field v-model="item.properties[key]" />
          </template>
          <template v-else>
            {{ item.properties[key] }}
          </template>
        </td>
      </tr>
    </tbody>
  </v-table>
  Set the count to 0 to delete Item
</template>
