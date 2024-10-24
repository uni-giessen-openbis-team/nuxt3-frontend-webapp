<script setup lang="ts">
import { ref, watch, computed } from 'vue';
import type { Sample } from '@/types/wizard'

const {samples, editable=true} = defineProps<{
  samples: Sample[]
  editable?: boolean
}>()

const emit = defineEmits(['update:sample']);

// Create a local copy of samples to track changes
const _samples = ref([...samples]);

// Watch for changes in the samples prop and update modelValue
watch(() => samples, (newSamples) => {
  _samples.value = [...newSamples];
}, { deep: true });

// Define headers for the v-data-table, conditionally including 'Parent'
const headers = computed(() => {
  const baseHeaders = [
    { title: 'Name', key: 'name' },
    { title: 'External DB ID', key: 'externalDBID' },
    { title: 'Count', key: 'count' },
    { title: 'Parent', key: 'parent' },
    { title: 'Conditions', key: 'conditions', sortable: false },
  ];

  // Check if any sample has a parent
  const hasParent = samples.some(sample => sample.parents);

  if (hasParent) {
    baseHeaders.splice(3, 0, { title: 'Parent', key: 'parent' }); // Insert 'Parent' before 'Conditions'
  }

  return baseHeaders;
});

// Watch for changes in modelValue and emit updates
watch(_samples, (newValue, oldValue) => {
  newValue.forEach((item, index) => {
    if (JSON.stringify(item) !== JSON.stringify(oldValue[index])) {
      emit('update:sample', { index, item });
    }
  });
}, { deep: true });

// Track the expansion state of each panel
const expandedPanels = ref(new Set<number>());

const togglePanel = (index: number) => {
  if (expandedPanels.value.has(index)) {
    expandedPanels.value.delete(index);
  } else {
    expandedPanels.value.add(index);
  }
};

const isPanelExpanded = (index: number) => expandedPanels.value.has(index);
</script>


<template>
  <v-data-table
    :headers="headers"
    :items="_samples"
    >
    
  <template #item.externalDBID="{ item }"> 
    <v-text-field
      v-model="item.externalDBID"
      type="text"
        variant="solo"
        :disabled="!editable"
    />
  </template>
  <template #item.name="{ item }">
    <v-text-field
      v-model="item.name"
      type="text"
        variant="solo"
        :disabled="!editable"
    />
  </template>
  <template #item.count="{ item }">
        <v-text-field
          v-model="item.count"
          type="number"
          max-width="80"
           variant="solo"
           :disabled="!editable"
        />
    </template>
      <template #item.parent="{ item }"> <!-- Updated template for Parent -->
      <span v-if="item.parents && item.parents.length > 0">
        {{ item.parents.join(', ') }}
      </span>
      <span v-else>
        N/A
      </span>
  </template>
  <template #item.conditions="{ item, index }">
    <v-expansion-panels>
      <v-expansion-panel>
        <v-expansion-panel-title @click="togglePanel(index)">
          {{ isPanelExpanded(index) ? 'Show Less' : 'Show More' }}
        </v-expansion-panel-title>
        <v-expansion-panel-text>
          <table style="width: 100%; border-collapse: separate; border-spacing: 0 10px;">
            <thead>
              <tr>
                <th style="text-align: left;">Property</th>
                <th style="text-align: left;">Term</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="(condition, indexb) in item.conditions" :key="indexb">
                <td style="padding: 10px;">{{ condition.propertyTitle }}</td>
                <td style="padding: 10px;">{{ condition.conditionTerm }}</td>
              </tr>
            </tbody>
          </table>
        </v-expansion-panel-text>
      </v-expansion-panel>
    </v-expansion-panels>
  </template>

  </v-data-table>
</template>

