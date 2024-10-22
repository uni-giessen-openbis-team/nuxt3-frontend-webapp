<script setup lang="ts">
import { toRef } from 'vue';
import type { Sample } from '@/types/wizard';
import { VueDraggableNext } from 'vue-draggable-next'

const props = defineProps<{
  samples: Sample[]
}>();

const samples = toRef(props, 'samples');
</script>

<template>  
  <div>
    <v-table>
      <thead>
        <tr>
          <th class="text-left">External DB ID</th>
          <th class="text-left">Name</th>
          <th class="text-right"/>
        </tr>
      </thead>
      <VueDraggableNext :list="samples" group="samples" tag="tbody" :component-data=" () => {}">
        <tr v-for="item in samples" :key="item.externalDBID">
          <td>{{ item.externalDBID }}</td>
          <td>{{ item.name }}</td>
        </tr>
      </VueDraggableNext>
    </v-table>
  </div>
</template>
