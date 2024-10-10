<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'

const emit = defineEmits(['update:list'])

const textInput = ref('')

const list = computed(() => textInput.value.split('\n'))

onMounted(() => {
  // Emit the computed list whenever it changes
  watchEffect(() => {
    emit('update:list', list.value)
  })
})

</script>

<template>
  <div>
    <v-textarea v-model="textInput" />
  </div>
</template>