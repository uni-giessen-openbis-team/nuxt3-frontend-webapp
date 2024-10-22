<script setup lang="ts">
import { ref, watch, onMounted, computed  } from 'vue';
import type { Sample } from '@/types/wizard';
import DraggableList from './DraggableList.vue';

const props = defineProps<{
  samples: Sample[]
}>();

const emit = defineEmits<{
  (e: 'update-pools', samples: Sample[]): void
}>();

const _samples = ref<Sample[]>([]);


// Initialize _samples with the prop value
onMounted(() => {
  _samples.value = [...props.samples];
});

// Watch for changes in the samples prop and update _samples
watch(() => props.samples, (newSamples) => {
  _samples.value = [...newSamples];
}, { deep: true, immediate: true });

// Manage pools
const pools = ref<{ id: number, samples: Sample[],name: string }[]>([]);

// Function to handle creating a new pool
const createNewPool = () => {
  pools.value.unshift({ id: pools.value.length + 1, samples: [],name: `pool_${pools.value.length +1}` });
};

// Function to handle removing a pool
const removePool = (poolIndex: number) => {
  // Transfer samples from the pool to _samples
  _samples.value.push(...pools.value[poolIndex]?.samples || []);
  // Remove the pool
  pools.value.splice(poolIndex, 1);
};

const combinedPoolSamples = computed<Sample[]>({
  get() {
    if (pools.value.length === 0 || pools.value.every(pool => pool.samples.length === 0)) {
      return []; // Return an empty array if no pools exist or if no samples are in any of the pools
    }
    const poolSamples: Sample[] = [];
    for (const pool of pools.value) {
      poolSamples.push({
        Id: pool.id.toString(),
        name: pool.name,
        externalDBID: pool.name,
        count: 1,
        parent: pool.samples.map(sample => sample.externalDBID),
        conditions: pool.samples.flatMap(sample => sample.conditions), // Unpack and combine conditions
      });
    }
    return poolSamples;
  },
  set(newSamples: Sample[]) {
    // Logic to update pools based on newSamples
    pools.value = newSamples.map(sample => ({
      id: parseInt(sample.Id),
      name: sample.name,
      samples: _samples.value.filter(s => sample.parent?.includes(s.externalDBID))
    }));
  }
});

// Watcher to emit changes
watch(combinedPoolSamples, (newSamples) => {
  emit('update-pools', newSamples);
}, { deep: true });

</script>

<template> 
Combined Pool Samples

  {{combinedPoolSamples}}
  <div class="drop-zone">
    <h3>Samples</h3>
    <DraggableList :samples="_samples" />
  </div>
  <br>
  <v-btn @click="createNewPool">
      <v-icon left>mdi-plus</v-icon>
      Pool
    </v-btn>
    <br>
  <div v-for="(pool, index) in pools" :key="pool.id" class="pool">
    <br>
    <v-row >
      <v-col >
         <v-text-field v-model="pool.name" label="Pool Name"  variant="plain"/>
      </v-col>
      <v-col >
        <v-btn size="small" @click="removePool(index)">
          <v-icon left>mdi-delete</v-icon>
        </v-btn>
      </v-col>
    </v-row>

    <DraggableList  :samples="pool.samples" />
    <br>

  </div>

</template>

