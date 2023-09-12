<script setup lang="ts">
import draggable from 'vuedraggable'
import type { Pool, combinedVariable } from '@/types/wizzard'
const { modelValue } = defineModels<{ modelValue: combinedVariable[] }>()

const poolLists = ref<Pool[]>([{
  id: 'initial',
  name: '',
  samples: [],
}])

const showPoolLists = ref(true)

const toggleList = () => {
  modelValue.value.push(...poolLists.value[0].samples)
  poolLists.value[0].samples = []

  showPoolLists.value = !showPoolLists.value
}

watch(poolLists, () => {
  // If the last pool's samples are not empty, append an empty pool
  if (poolLists.value[poolLists.value.length - 1].samples.length > 0) {
    poolLists.value.push({
      id: `pool${poolLists.value.length + 1}`,
      name: '',
      samples: [],
    })
  }

  // Count empty pools
  const emptyPoolsCount = poolLists.value.reduce((count, pool) => pool.samples.length === 0 ? count + 1 : count, 0)

  // If there are more than one empty pools, remove the first one
  if (emptyPoolsCount > 1) {
    for (let i = 0; i < poolLists.value.length; i++) {
      if (poolLists.value[i].samples.length === 0) {
        poolLists.value.splice(i, 1)
        break
      }
    }
  }
}, { deep: true })
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
    <draggable v-model="modelValue" item-key="secondaryName" tag="tbody" group="people">
      <template #item="{ element, index }">
        <tr :key="index">
          <td v-for="key in ['externalDBID', 'secondaryName', ...Object.keys(element).filter(k => !['externalDBID', 'secondaryName'].includes(k))]" :key="key">
            <template v-if="['count', 'externalDBID', 'secondaryName'].includes(key)">
              <v-text-field v-model="element[key]" />
            </template>
            <template v-else>
              {{ element[key] }}
            </template>
          </td>
        </tr>
      </template>
    </draggable>
  </v-table>
  <br>
  <v-btn @click="toggleList">
    Pool Samples
  </v-btn>  <!-- Step 3 -->

  <v-container v-if="showPoolLists">
    <v-card v-for="(pool, i) in poolLists" :key="pool.id">
      <v-row>
        <v-col>
          <v-card-title>Pool {{ i + 1 }}</v-card-title>
        </v-col>
        <v-text-field
          v-model="pool.name"
          label="Name of Pool"
        />
      </v-row>
      <v-table>
        <thead>
          <tr>
            <th v-for="key in ['externalDBID', 'secondaryName', ...Object.keys(modelValue[0] ?? {}).filter(k => !['externalDBID', 'secondaryName'].includes(k))]" :key="key">
              {{ key }}
            </th>
          </tr>
        </thead>
        <draggable v-model="pool.samples" item-key="secondaryName" tag="tbody" group="people">
          <template #item="{ element, index }">
            <tr v-if="showPoolLists" :key="index">
              <td v-for="key in ['externalDBID', 'secondaryName', ...Object.keys(element).filter(k => !['externalDBID', 'secondaryName'].includes(k))]" :key="key">
                <template v-if="['count', 'externalDBID', 'secondaryName'].includes(key)">
                  <v-text-field v-model="element[key]" />
                </template>
                <template v-else>
                  {{ element[key] }}
                </template>
              </td>
            </tr>
          </template>
        </draggable>
        <br>
      </v-table>
      <br>
    </v-card>
  </v-container>
</template>
