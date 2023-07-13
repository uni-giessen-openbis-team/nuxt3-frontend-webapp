<script setup lang="ts">
import { onMounted, ref, watchEffect } from 'vue'

const emit = defineEmits(['update:modelValue'])
const textInput = ref('')
onMounted(() => {
  watchEffect(() => {
    const list = textInput.value.split('\n')
    emit('update:modelValue', list)
  })
})
</script>

<template>
  <div>
    <v-textarea v-model="textInput" />
  </div>
</template>
