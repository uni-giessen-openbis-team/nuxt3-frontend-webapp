// @ts-ignore
<script setup lang="ts">
import type openbis from '~/composables/openbis.esm';


const modelValue = defineModel<openbis.SampleCreation[]>();

</script>

<template>
  <v-table v-if="modelValue">
    <thead>
      <tr>
        <th v-for="(key, index) in Object.keys(modelValue[0]?.properties ?? {})" :key="index">
          {{ key }}
        </th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="(item, index) in modelValue" :key="index">
        <td v-for="key in Object.keys(item.properties)" :key="key">
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
