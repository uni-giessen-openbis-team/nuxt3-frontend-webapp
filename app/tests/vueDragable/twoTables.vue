<script setup lang="ts">
import { ref, watch } from 'vue';
import type { Sample } from '@/types/wizard';
import { VueDraggableNext } from 'vue-draggable-next'

// Define props to accept samples directly
const props = defineProps<{
  samples: Sample[]
}>()

// Create a local copy of samples to track changes
const _samples = ref([...props.samples]);

// Watch for changes in the samples prop and update _samples
watch(() => props.samples, (newSamples) => {
  _samples.value = [...newSamples];
}, { deep: true });

// Manage pools
const pools = ref<{ id: number, samples: Sample[] }[]>([]);

// Function to handle creating a new pool
const createNewPool = () => {
  pools.value.push({ id: pools.value.length, samples: [] });
};

// Function to handle removing a pool
const removePool = (poolIndex: number) => {
  pools.value.splice(poolIndex, 1);
};
</script>

<template>
  <div class="drop-zone">
    <h3>Samples</h3>
    <button @click="createNewPool">Create New Pool</button>
    <v-table height="300px">
      <thead>
        <tr>
          <th class="text-left">External DB ID</th>
          <th class="text-left">Name</th>
          <th class="text-left">Count</th>
          <th class="text-left">Parent</th>
          <th class="text-left">Conditions</th>
        </tr>
      </thead>
      <draggable :list="_samples" group="samples" tag="tbody">
        <tr v-for="item in _samples" :key="item.externalDBID">
          <td>{{ item.externalDBID }}</td>
          <td>{{ item.name }}</td>
          <td>{{ item.count }}</td>
          <td>{{ item.parents || 'N/A' }}</td>
          <td>
            <ul>
              <li v-for="condition in item.conditions" :key="condition.propertyTitle">
                {{ condition.propertyTitle }}: {{ condition.conditionTerm }}
              </li>
            </ul>
          </td>
        </tr>
      </draggable>
    </v-table>
  </div>

  <div v-for="(pool, index) in pools" :key="pool.id" class="pool">
    <h3>Pool {{ index + 1 }}</h3>
    <button @click="removePool(index)">Remove Pool</button>
    <v-table height="300px">
      <thead>
        <tr>
          <th class="text-left">External DB ID</th>
          <th class="text-left">Name</th>
          <th class="text-left">Count</th>
          <th class="text-left">Parent</th>
          <th class="text-left">Conditions</th>
        </tr>
      </thead>
      <draggable :list="pool.samples" group="samples" tag="tbody">
        <tr v-for="item in pool.samples" :key="item.externalDBID">
          <td>{{ item.externalDBID }}</td>
          <td>{{ item.name }}</td>
          <td>{{ item.count }}</td>
          <td>{{ item.parents || 'N/A' }}</td>
          <td>
            <ul>
              <li v-for="condition in item.conditions" :key="condition.propertyTitle">
                {{ condition.propertyTitle }}: {{ condition.conditionTerm }}
              </li>
            </ul>
          </td>
        </tr>
      </draggable>
    </v-table>
  </div>
</template>

<style scoped>
.drop-zone {
  padding: 16px;
}

.pool {
  margin-top: 20px;
}
</style>
