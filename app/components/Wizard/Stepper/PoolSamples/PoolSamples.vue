<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import type { Sample } from '@/types/wizard';

const props = defineProps<{
  samples: Sample[]
}>();

const _samples = ref<Sample[]>([]);
const newPoolName = ref('');

onMounted(() => {
  _samples.value = props.samples;
});

const uniquePools = computed(() => {
  const poolSet = new Set<string>();
  _samples.value.forEach(sample => {
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
    _samples.value.forEach(sample => {
      sample.pools?.push(newPoolName.value);
    });
    newPoolName.value = '';
  }
}
</script>

<template>
    <div>
      <h4>Add New Pool</h4>
      <input v-model="newPoolName" placeholder="Enter pool name" >
      <v-btn @click="addNewPool">
        <v-icon>mdi-plus</v-icon>
        Add Pool</v-btn>
    </div>
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
        <tr v-for="sample in _samples" :key="sample.id">
          <td>{{ sample.name }}</td>
          <td v-for="pool in uniquePools" :key="pool">
            <input type="checkbox" :checked="sample.pools?.includes(pool)" @change="togglePool(sample, pool)" >
          </td>
        </tr>
      </tbody>
    </v-table>

  

  </div>
  Samples
  <pre> {{ _samples }} </pre>
</template>
