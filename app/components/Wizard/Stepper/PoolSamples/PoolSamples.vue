<script setup lang="ts">
import { computed, ref } from 'vue';
import type { Sample } from '@/types/wizard';

const samples = defineModel<Sample[]>('samples');

const newPoolName = ref('');

const uniquePools = computed(() => {
  const poolSet = new Set<string>();
  samples.value?.forEach(sample => {
    sample.pools?.forEach(pool => poolSet.add(pool));
  });
  return Array.from(poolSet);
});

function togglePool(sample: Sample, pool: string) {
  const poolIndex = sample.pools?.indexOf(pool);
  if (poolIndex === -1) {
    sample.pools?.push(pool);
  } else {
    sample.pools?.splice(poolIndex, 1);
  }
}

function addNewPool() {
  if (!newPoolName.value) {
    alert('Please enter a pool name.');
    return;
  }
  if (!uniquePools.value.includes(newPoolName.value)) {
    samples.value?.forEach(sample => {
      sample.pools?.push(newPoolName.value);
    });
    newPoolName.value = '';
  }
}
</script>

<template>
  <div>
    <h4>Add New Pool</h4>
    <v-text-field v-model="newPoolName" placeholder="Enter pool name" >
      <template #append-inner>
    <v-btn @click="addNewPool">
      <v-icon>mdi-plus</v-icon>
    </v-btn>
  </template>
</v-text-field></div>
  <div>
    <h3>Samples</h3>
    <v-table>
      <thead>
        <tr>
          <th>Sample Name</th>
          <th v-for="pool in uniquePools" :key="pool">{{ pool }}</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="sample in samples" :key="sample.id">
          <td>{{ sample.name }}</td>
          <td v-for="pool in uniquePools" :key="pool">
            <input type="checkbox" :checked="sample.pools?.includes(pool)" @change="togglePool(sample, pool)" >
          </td>
        </tr>
      </tbody>
    </v-table>
  </div>
</template>
