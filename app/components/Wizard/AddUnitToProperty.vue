<template>
  <div>
    <v-checkbox :value="continuous" label="continuous" @change="updateContinuous" />
    <div v-if="continuous">
      Unit
      <v-text-field :value="unit" @input="updateUnit" />
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref, defineEmits } from 'vue';

const continuous = ref(false);
const unit = ref('');

const emit = defineEmits(['update:continuous', 'update:unit']);

function updateContinuous(value: boolean) {
  continuous.value = value;
  emit('update:continuous', value);
}

function updateUnit(value: string) {
  unit.value = value;
  emit('update:unit', value);
}
 
</script>

