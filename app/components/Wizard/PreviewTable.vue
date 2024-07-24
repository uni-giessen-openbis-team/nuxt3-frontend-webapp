<script setup lang="ts">
const  modelValue= defineModel()
</script>

<template>
  <v-table>
    <thead>
      <tr>
        <th v-for="key in ['externalDBID', 'secondaryName', ...Object.keys(modelValue[0] ?? {}).filter(k => !['externalDBID', 'secondaryName'].includes(k))]" :key="key">
          {{ key }}
        </th>
      </tr>
    </thead>
    <tbody>
      <tr v-for="(item, index) in modelValue" :key="index">
        <td v-for="key in ['externalDBID', 'secondaryName', ...Object.keys(item).filter(k => !['externalDBID', 'secondaryName'].includes(k))]" :key="key">
          <template v-if="['count', 'externalDBID', 'secondaryName'].includes(key)">
            <v-text-field v-model="item[key]" />
          </template>
          <template v-else>
            {{ item[key] }}
          </template>
        </td>
      </tr>
    </tbody>
  </v-table>
  Set the count to 0 to delte Item
</template>
