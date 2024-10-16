<template>
  <div>
    <v-checkbox  
      v-model="continuous"
      label="continuous" />
    <div v-if="continuous">
      Unit
      <v-text-field v-model="unit" />
    </div>
  </div>
</template>

<script lang="ts" setup>

const continuous = ref(false);
const unit = ref('');

const emit = defineEmits(['update:continuous', 'update:unit']);

// Watch for changes in 'continuous' and emit an event
watch(continuous, (newValue) => {
  emit('update:continuous', newValue);
});

// Watch for changes in 'unit' and emit an event
watch(unit, (newValue) => {
  emit('update:unit', newValue);
});

 
</script>

